---Comparison of Different Fee Rate
select concat(format('%,.2f', fee / 1e4), '%') as fee_tier,
    count(*) as pool_count
from uniswap_v3_ethereum.Factory_evt_PoolCreated
group by 1
order by fee_tier asc

---Pancake V3
select concat(format('%,.2f', fee / 1e4), '%') as fee_tier,
    count(*) as pool_count
from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated
group by 1
order by fee_tier asc