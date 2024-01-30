with hourly_trade_summary as (
    select date_trunc('day', block_time) as block_date, 
        sum(number_of_items) as items_traded,
        sum(amount_raw) / 1e18 as amount_raw_traded,
        sum(amount_usd) as amount_usd_traded
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
    -- and block_time > now() - interval '90' day
    group by 1
    order by 1
)

select block_date, 
    items_traded,
    amount_raw_traded,
    amount_usd_traded,
    sum(items_traded) over (order by block_date asc) as accumulate_items_traded,
    sum(amount_raw_traded) over (order by block_date asc) as accumulate_amount_raw_traded,
    sum(amount_usd_traded) over (order by block_date asc) as accumulate_amount_usd_traded
from hourly_trade_summary
order by block_date
