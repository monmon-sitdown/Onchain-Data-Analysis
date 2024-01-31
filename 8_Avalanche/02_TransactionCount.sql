with total_transactions as (
    select count(*) / 1e6 as transaction_count
    from avalanche_c.transactions
),

total_accounts as (
    select count(distinct "to") as account_count
    from avalanche_c.traces
),

total_contracts as (
    select count(distinct contract_address) as contract_count
    from avalanche_c.logs
)

select transaction_count,
    account_count,
    contract_count
from total_transactions
join total_accounts on true
join total_contracts on true

