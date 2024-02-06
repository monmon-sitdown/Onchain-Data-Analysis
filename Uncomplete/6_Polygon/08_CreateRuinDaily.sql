with polygon_contracts as (
    select date_trunc('day', block_time) as block_date,
        type,
        count(*) as transactions_count
    from polygon.traces
    where type in ('create', 'suicide')
    group by 1, 2
)

select block_date, 
    type,
    transactions_count,
    sum(transactions_count) over (partition by type order by block_date) as accumulate_transactions_count
from polygon_contracts
order by block_date