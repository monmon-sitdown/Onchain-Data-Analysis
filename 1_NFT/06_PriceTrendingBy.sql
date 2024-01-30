with nft_trade_details as (
    select block_time, amount_raw / coalesce(number_of_items, 1) / 1e18 as amount_eth
    from nft.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and currency_symbol in ('ETH', 'WETH')
        and block_time > date('2022-01-01')
),

nft_daily_highest_lowest_price as (
    select date_trunc('day', block_time) as block_date,
        max(amount_eth) as max_amount_eth,
        min(amount_eth) as min_amount_eth,
        avg(amount_eth) as avg_amount_eth
    from nft_trade_details
    group by 1
    order by 1
)

select block_date,
    max_amount_eth,
    min_amount_eth,
    avg_amount_eth,
    avg(max_amount_eth) over (order by block_date rows between 6 preceding and current row) as ma_7day_amount_eth
from nft_daily_highest_lowest_price
order by block_date
