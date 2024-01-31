with users_transaction as (
    select "from" as account, block_time
    from avalanche_c.transactions
    union
    select "to" as account, block_time
    from avalanche_c.transactions
),

new_users_date as (
    select account,
        min(block_time) as min_block_time
    from users_transaction
    group by account
    order by 2
),

new_users_weekly as (
    select date_trunc('week', min_block_time) as block_date,
        count(distinct account) as new_users_count
    from new_users_date
    group by 1
    order by 1
)

select block_date,
    new_users_count,
    sum(new_users_count) over (order by block_date) as accumulate_new_users_count
from new_users_weekly
order by block_date