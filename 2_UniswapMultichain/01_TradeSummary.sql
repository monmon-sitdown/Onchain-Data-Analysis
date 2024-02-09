with transaction_summary as (
    select blockchain,
        sum(amount_usd) as trade_amount,
        count(*) as transaction_count,
        count(distinct taker) as user_count
    from uniswap.trades
    where block_time >= date('2023-01-01')
        and block_time < date('2024-01-01')
    group by 1
)

select blockchain,
    trade_amount / 1e9 as trade_amount,
    transaction_count / 1e6 as transaction_count,
    user_count / 1e6 as user_count,
    sum(trade_amount) over () / 1e9 as total_trade_amount,
    sum(transaction_count) over () / 1e6 as total_transaction_count,
    sum(user_count) over () / 1e6 as total_user_count
from transaction_summary
order by blockchain