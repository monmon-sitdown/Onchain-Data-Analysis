---Total Daily Creation of Liquidity Pools in the last 30 Days
with pool_details as (
    select date_trunc('day', evt_block_time) as block_date, evt_tx_hash, pool
    from uniswap_v3_ethereum.Factory_evt_PoolCreated
    where evt_block_time >= now() - interval '29' day
)

select block_date, count(pool) as pool_count
from pool_details
group by 1
order by 1

---Pancake V3 ETH
with pool_details as (
    select date_trunc('day', evt_block_time) as block_date, evt_tx_hash, pool
    from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated
    where evt_block_time >= now() - interval '29' day
)

select block_date, count(pool) as pool_count
from pool_details
group by 1
order by 1

---Comparison between uni and pancake
with pool_details as (
    select 'Pancake' as DEX, date_trunc('day', evt_block_time) as block_date, evt_tx_hash, pool
    from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated
    where evt_block_time >= now() - interval '29' day
    union
    select 'Uni' as DEX, date_trunc('day', evt_block_time) as block_date, evt_tx_hash, pool
    from uniswap_v3_ethereum.Factory_evt_PoolCreated
    where evt_block_time >= now() - interval '29' day
)

select DEX, block_date, count(pool) as pool_count
from pool_details
group by DEX, block_date
order by block_date

