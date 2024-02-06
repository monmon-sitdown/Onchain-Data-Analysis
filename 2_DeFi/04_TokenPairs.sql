with top_token_pair as (
    select token_pair,
        count(*) as transaction_count
    from dex.trades
    where blockchain = 'ethereum'
        and block_date >= date('2021-01-01')
        and token_pair <> 'POP-WETH' -- Exclude outlier that has wrong amount
    group by 1
    order by 2 desc
    limit 20
)

select date_trunc('month', block_date) as block_date,
    token_pair,
    count(*) as trade_count,
    count(distinct taker) as active_user_count,
    sum(amount_usd) as trade_amount
from dex.trades
where blockchain = 'ethereum'
    and block_date >= date('2021-01-01')
    and token_pair in (
        select token_pair from top_token_pair
    )
group by 1, 2
order by 1, 2