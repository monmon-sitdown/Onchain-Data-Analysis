with monthly_active_user as (
    select distinct taker as address,
        date_trunc('month', block_date) as active_trade_month
    from uniswap_v3_ethereum.trades
),

user_initial_trade as (
    select taker as address,
        min(date_trunc('month', block_date)) as initial_trade_month
    from uniswap_v3_ethereum.trades
    group by 1
),

user_status_detail as (
    select coalesce(c.active_trade_month, date_trunc('month', p.active_trade_month + interval '45' day)) as trade_month,
        coalesce(c.address, p.address) as address,
        (case when n.address is not null then 1 else 0 end) as is_new,
        (case when n.address is null and c.address is not null and p.address is not null then 1 else 0 end) as is_retained,
        (case when n.address is null and c.address is null and p.address is not null then 1 else 0 end) as is_churned,
        (case when n.address is null and c.address is not null and p.address is null then 1 else 0 end) as is_returned
    from monthly_active_user c
    full join monthly_active_user p on p.address = c.address and p.active_trade_month = date_trunc('month', c.active_trade_month - interval '5' day)
    left join user_initial_trade n on n.address = c.address and n.initial_trade_month = c.active_trade_month
    where coalesce(c.active_trade_month, date_trunc('month', p.active_trade_month + interval '45' day)) < current_date
),

user_status_summary as (
    select trade_month,
        address,
        (case when sum(is_new) >= 1 then 'New'
            when sum(is_retained) >= 1 then 'Retained'
            when sum(is_churned) >= 1 then 'Churned'
            when sum(is_returned) >= 1 then 'Returned'
        end) as user_status
    from user_status_detail
    group by 1, 2
),

monthly_summary as (
    select trade_month,
        user_status,
        count(address) as user_count
    from user_status_summary
    group by 1, 2
)

select trade_month,
    user_status,
    (case when user_status = 'Churned' then -1 * user_count else user_count end) as user_count
from monthly_summary
order by 1, 2