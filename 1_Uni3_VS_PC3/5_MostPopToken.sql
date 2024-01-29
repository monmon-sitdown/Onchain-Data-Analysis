---Most Popular Token by Number of Liquidity Pools of Uni
with pool_details as (
    select token0 as token_address,
        evt_tx_hash, pool
    from uniswap_v3_ethereum.Factory_evt_PoolCreated

    union all

    select token1 as token_address,
        evt_tx_hash, pool
    from uniswap_v3_ethereum.Factory_evt_PoolCreated
),

token_pool_summary as (
    select token_address,
        count(pool) as pool_count
    from pool_details
    group by 1
    order by 2 desc
    limit 100
)

select t.symbol, p.token_address, p.pool_count
from token_pool_summary p
inner join tokens.erc20 t on p.token_address = t.contract_address
order by 3 desc

---Pancakge V3
with pool_details as (
    select token0 as token_address,
        evt_tx_hash, pool
    from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated

    union all

    select token1 as token_address,
        evt_tx_hash, pool
    from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated

),

token_pool_summary as (
    select token_address,
        count(pool) as pool_count
    from pool_details
    group by 1
    order by 2 desc
    limit 100
)

select t.symbol, p.token_address, p.pool_count
from token_pool_summary p
inner join tokens.erc20 t on p.token_address = t.contract_address
order by 3 desc