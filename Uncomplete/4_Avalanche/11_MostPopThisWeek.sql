with top_contracts as (
    select contract_address,
        count(distinct tx_hash) as activity_count
    from avalanche_c.logs
    where block_time >= now() - interval '7' day
    group by 1
    order by 2 desc
    limit 50
)

select row_number() over (order by activity_count desc) as rank_id,
    contract_address,
    activity_count
from top_contracts
order by activity_count desc