with top_contracts as (
    select contract_address,
        count(*) as activity_count
    from avalanche_c.logs
    group by contract_address
    order by 2 desc
    limit 50
)

select date_trunc('day', block_time) as block_date,
    contract_address,
    count(*) as activity_count
from avalanche_c.logs l
where contract_address in (select contract_address from top_contracts)
    and block_time >= '2021-08-01' -- Exclude early dates with less data
group by 1, 2
order by 1, 2

