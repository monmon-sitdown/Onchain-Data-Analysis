--- Weekly Summary of Newly Created Liquidity Pools
select block_date, count(pool) as pool_count
from (
    select date_trunc('week', evt_block_time) as block_date,
        evt_tx_hash,
        pool
    from uniswap_v3_ethereum.Factory_evt_PoolCreated
)
group by 1
order by 1

---Pancake V3 Eth
with result as (
select 'pancake' as DEX, date_trunc('week', evt_block_time) as block_date,evt_tx_hash, pool
   	from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated

)

select DEX, block_date, count(pool) as pool_count
from result
group by DEX, block_date
order by block_date

---Uni3 VS Pancake3
with result as (
select 'pancake' as DEX, date_trunc('week', evt_block_time) as block_date,evt_tx_hash, pool
   	from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated
	union
select 'uni' as DEX, date_trunc('week', evt_block_time) as block_date,evt_tx_hash, pool
   	from uniswap_v3_ethereum.Factory_evt_PoolCreated

)

select DEX, block_date, count(pool) as pool_count
from result
group by DEX, block_date
order by block_date
