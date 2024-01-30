-- 按时间排序，找出该合约最近的10笔交易
with lastest_trades as (
    select * 
    from nft.trades 
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544 -- azuki NFT的合约地址
    -- and block_time > now() - interval '24' hour --也可以按时间排序
    order by block_time desc
    limit 10
)

select min(amount_original) as floor_price --直接获取最小值
    -- percentile_cont(.05) within GROUP (order by amount_original) as floor_price --这么做是取最低和最高价之间5%分位数，防止一些过低的价格交易影响
from lastest_trades
where  currency_symbol IN ('ETH', 'WETH')
    and cast(number_of_items as integer) = 1 -- 这里可以按不同的链，不同的交易token进行过滤