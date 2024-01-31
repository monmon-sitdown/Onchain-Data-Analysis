select type,
    count(*) / 1e6 as transactions_count
from polygon.traces
where type in ('create', 'suicide')
    and block_time >= date('2023-01-01') -- 这里为了性能考虑加了日期条件
group by 1
order by 1