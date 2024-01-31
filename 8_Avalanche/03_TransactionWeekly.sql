with contracts_weekly as (
    select date_trunc('week', block_time) as block_date,
          count(distinct contract_address) as contract_count
    from avalanche_c.logs

    group by 1
    order by 1
)

select block_date,
    contract_count,
    sum(contract_count) over (order by block_date) as accumulate_contract_count
from contracts_weekly
order by block_date