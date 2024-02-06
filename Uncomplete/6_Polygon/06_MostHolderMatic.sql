with polygon_transfer_raw as (
    select "from" as address, (-1) * cast(value as decimal) as amount
    from polygon.traces
    where call_type = 'call'
        and success = true
        and value > uint256 '0'
    
    union all
    
    select "to" as address, cast(value as decimal) as amount
    from polygon.traces
    where call_type = 'call'
        and success = true
        and value > uint256 '0'
)

select address,
    sum(amount) / 1e18 as amount
from polygon_transfer_raw
group by 1
order by 2 desc
limit 1000