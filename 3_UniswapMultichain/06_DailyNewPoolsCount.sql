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

daily_pool_summary as (
    select date_trunc('day', evt_block_time) as block_date,
        blockchain,
        count(distinct pool) as pool_count
    from pool_created_detail
    group by 1, 2
)

select block_date,
    blockchain,
    pool_count,
    sum(pool_count) over (partition by blockchain order by block_date) as accumulate_pool_count
from daily_pool_summary
where block_date >= date('2023-01-01')
    and block_date < date('2024-01-01')
order by block_date
