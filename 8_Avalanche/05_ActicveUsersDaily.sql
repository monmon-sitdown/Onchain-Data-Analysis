with users_weekly as (
    select date_trunc('week', block_time) as block_date,
        count(distinct "from") as active_users_count
    from avalanche_c.transactions
    group by 1
    order by 1
)

select block_date,
    active_users_count,
    sum(active_users_count) over (order by block_date) as accumulate_active_users_count
from users_weekly
order by block_date