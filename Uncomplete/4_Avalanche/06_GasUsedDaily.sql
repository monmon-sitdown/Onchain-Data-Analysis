with transactionn_gas_used as (
    select block_time, gas_price, gas_used, gas_price * gas_used as gas_amount, hash
    from avalanche_c.transactions
)

select date_trunc('day', block_time) as block_date,
    count(*) as transaction_count,
    avg(gas_price) / 1e9 as average_gas_price,
    sum(gas_used) / 1e9 as sum_gas_used,
    avg(gas_used) as average_gas_used,
    sum(gas_amount) / 1e18 as sum_gas_amount,   -- Not reiliable
    avg(gas_amount) / 1e18 as average_gas_amount    -- Not reiliable
from transactionn_gas_used
group by 1
order by 1
