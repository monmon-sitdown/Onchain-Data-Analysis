---Total Number of Liquidity PoolsUni VS Pancake(V3 ETH pool_count)
select 'PancakeV3eth' as DEX_name,count(*) as pool_count
from pancakeswap_v3_ethereum.PancakeV3Factory_evt_PoolCreated
union
select 'UniV3eth' as DEX_name,count(*) as pool_count
from uniswap_v3_ethereum.Factory_evt_PoolCreated