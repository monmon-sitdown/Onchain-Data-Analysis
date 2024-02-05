select block_date,
    project,
    count(*) as trade_count,
    count(distinct taker) as active_user_count,
    sum(amount_usd) as trade_amount
from dex.trades
where blockchain = 'ethereum'
    and block_date >= date('2021-01-01')
    and token_pair <> 'POP-WETH' -- Exclude outlier that has wrong amount
group by 1, 2
order by 1, 2

