with new_contract_date as (
    select contract_address,
        count(*) as activity_count
    from avalanche_c.logs
    group by contract_address
    order by 2 desc
)

select contract_address,
    ---'<a href=https://avascan.info/blockchain/c/address/' || contract_address || ' target=_blank>Avascan</a>' as arbiscan_link,
    activity_count
from new_contract_date
limit 100
