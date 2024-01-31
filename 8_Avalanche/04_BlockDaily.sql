select date_trunc('day', time) as block_date,
    count("number") as block_count,
    86400 / count("number") as time_per_block
from avalanche_c.blocks
group by 1
order by 1 desc