with top_contracts as (
    select "to" as contract_address,
        count(*) as transaction_count
    from polygon.transactions
    where success = true
    group by 1
    order by 2 desc
    limit 20
)

select date_trunc('day', block_time) as block_date, 
    contract_address,
    count(*) as transaction_count
from polygon.transactions t
inner join top_contracts c on t."to" = c.contract_address
group by 1, 2
order by 1, 2