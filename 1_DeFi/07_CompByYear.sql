select
    sum(case when block_date >= date('2021-01-01') and block_date < date('2022-01-01') then trade_amount else 0 end) as trade_amount_2021,
    sum(case when block_date >= date('2022-01-01') and block_date < date('2023-01-01') then trade_amount else 0 end) as trade_amount_2022,
    sum(case when block_date >= date('2023-01-01') and block_date < date('2024-01-01') then trade_amount else 0 end) as trade_amount_2023
from query_3390603 ---column别

with trade21 as (
    select '2021' as year,
    sum(trade_amount) / 1e9 as total_trade_amount,
    sum(trade_count) / 1e6 as total_trade_count,
    sum(active_user_count) / 1e6 as total_user_count
    from query_3390603
    where block_date >= date('2021-01-01')
    and block_date < date('2022-01-01')
),

trade22 as (
    select '2022' as year,
    sum(trade_amount) / 1e9 as total_trade_amount,
    sum(trade_count) / 1e6 as total_trade_count,
    sum(active_user_count) / 1e6 as total_user_count
    from query_3390603
    where block_date >= date('2022-01-01')
    and block_date < date('2023-01-01')
), 

trade23 as (
    select '2023' as year,
    sum(trade_amount) / 1e9 as total_trade_amount,
    sum(trade_count) / 1e6 as total_trade_count,
    sum(active_user_count) / 1e6 as total_user_count
    from query_3390603
    where block_date >= date('2023-01-01')
    and block_date < date('2024-01-01')
)

select *
from trade21
union
select *
from trade22
union
select *
from trade23