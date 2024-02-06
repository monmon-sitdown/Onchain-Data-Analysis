with new_contract as (
    select contract_address,
        min_block_time
    from (
        select contract_address,
            min(block_time) as min_block_time
        from avalanche_c.logs
        group by contract_address
        order by 2
    ) c
    where min_block_time >= now() - interval '7' day
),

top_new_contracts as (
    select contract_address,
        count(distinct tx_hash) as activity_count
    from avalanche_c.logs
    where contract_address in (select contract_address from new_contract)
    and block_time >= now() - interval '7' day
    group by 1
    order by 2 desc
    limit 50
)

select row_number() over (order by activity_count desc) as rank_id,
    contract_address,
    activity_count
from top_new_contracts
order by activity_count desc