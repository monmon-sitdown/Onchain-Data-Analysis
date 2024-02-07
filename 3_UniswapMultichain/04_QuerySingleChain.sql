select block_date,
    active_user_count,
    new_user_count,
    retain_user_count
from query_3412141 -- This points to all returned data from query https://dune.com/queries/1928825
where blockchain = 'etherum'
order by block_date