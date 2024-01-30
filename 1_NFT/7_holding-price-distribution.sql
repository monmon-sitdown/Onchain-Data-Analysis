with nft_trade_details as (
    select block_time,
        token_id,
        amount_raw / 1e18 as amount_eth      
    from nft.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
    and block_time > date('2022-01-01')
),
---all transaction info of azuki

nft_trade_details_rown_number as (
    select row_number() over (partition by token_id order by block_time desc) as row_num,
        block_time,
        token_id,
        amount_eth
    from nft_trade_details
),
---grouped by token_id, and numbered them, selected every tokens' info

latest_nft_trade_by_token as (
    select block_time,
        token_id,
        amount_eth
    from nft_trade_details_rown_number
    where row_num = 1 
),
--- the latest trade by token 

min_max_price as (
    select min(amount_eth) as min_price,
        max(amount_eth) as max_price
    from nft_trade_details
),
---min max price of all trade

price_bin as (
    select (max_price - min_price) / 20.0 as bin_price
    from min_max_price
),
--- 

bucket_nft_trade as (
    select *,
    ceil(amount_eth / bin_price) * bin_price as gap_price
  from latest_nft_trade_by_token
  inner join price_bin on true
  inner join min_max_price on true
 )
 ---
 
select round(gap_price, 4) as gap_price,
    count(*) as holder_count
from bucket_nft_trade
group by gap_price
order by gap_price 
