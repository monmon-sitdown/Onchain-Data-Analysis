with pool_created_detail as (
    select 'ethereum' as blockchain,
        evt_block_time,
        evt_tx_hash,
        pool,
        token0,
        token1
    from uniswap_v3_ethereum.Factory_evt_PoolCreated

    union all
    
    select 'arbitrum' as blockchain,
        evt_block_time,
        evt_tx_hash,
        pool,
        token0,
        token1
    from uniswap_v3_arbitrum.UniswapV3Factory_evt_PoolCreated

    union all
    
    select 'optimism' as blockchain,
        evt_block_time,
        evt_tx_hash,
        pool,
        token0,
        token1
    from uniswap_v3_optimism.Factory_evt_PoolCreated

    union all
    
    select 'polygon' as blockchain,
        evt_block_time,
        evt_tx_hash,
        pool,
        token0,
        token1
    from uniswap_v3_polygon.factory_polygon_evt_PoolCreated
),

token_transfer_detail as (
    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."to" as pool,
        cast(t.value as double) as amount_original
    from erc20_arbitrum.evt_Transfer t
    inner join pool_created_detail p on t."to" = p.pool
    where p.blockchain = 'arbitrum'

    union all

    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."from" as pool,
        -1 * cast(t.value as double) as amount_original
    from erc20_arbitrum.evt_Transfer t
    inner join pool_created_detail p on t."from" = p.pool
    where p.blockchain = 'arbitrum'

    union all
    
    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."to" as pool,
        cast(t.value as double) as amount_original
    from erc20_ethereum.evt_Transfer t
    inner join pool_created_detail p on t."to" = p.pool
    where p.blockchain = 'ethereum'

    union all

    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."from" as pool,
        -1 * cast(t.value as double) as amount_original
    from erc20_ethereum.evt_Transfer t
    inner join pool_created_detail p on t."from" = p.pool
    where p.blockchain = 'ethereum'

    union all
    
    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."to" as pool,
        cast(t.value as double) as amount_original
    from erc20_optimism.evt_Transfer t
    inner join pool_created_detail p on t."to" = p.pool
    where p.blockchain = 'optimism'

    union all

    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."from" as pool,
        -1 * cast(t.value as double) as amount_original
    from erc20_optimism.evt_Transfer t
    inner join pool_created_detail p on t."from" = p.pool
    where p.blockchain = 'optimism'

    union all
    
    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."to" as pool,
        cast(t.value as double) as amount_original
    from erc20_polygon.evt_Transfer t
    inner join pool_created_detail p on t."to" = p.pool
    where p.blockchain = 'polygon'

    union all

    select p.blockchain,
        t.contract_address,
        t.evt_block_time,
        t.evt_tx_hash,
        t."from" as pool,
        -1 * cast(t.value as double) as amount_original
    from erc20_polygon.evt_Transfer t
    inner join pool_created_detail p on t."from" = p.pool
    where p.blockchain = 'polygon'
),

token_list as (
    select distinct contract_address
    from token_transfer_detail
),

latest_token_price as (
    select contract_address, symbol, decimals, price, minute
    from (
        select row_number() over (partition by contract_address order by minute desc) as row_num, *
        from prices.usd
        where contract_address in ( 
                select contract_address from token_list 
            )
            and minute >= now() - interval '1' day
        order by minute desc
    ) p
    where row_num = 1
),

token_transfer_detail_amount as (
    select blockchain,
        d.contract_address,
        evt_block_time,
        evt_tx_hash,
        pool,
        amount_original,
        amount_original / pow(10, decimals) * price as amount_usd
    from token_transfer_detail d
    inner join latest_token_price p on d.contract_address = p.contract_address
)

select blockchain,
    sum(amount_usd) as tvl,
    (sum(sum(amount_usd)) over ()) / 1e9 as total_tvl
from token_transfer_detail_amount
where abs(amount_usd) < 1e9 -- Exclude some outlier values from Optimism chain
group by 1