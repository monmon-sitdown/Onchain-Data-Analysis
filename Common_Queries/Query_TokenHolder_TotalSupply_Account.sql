---Contract address of ERC20
select * from tokens.erc20
where symbol = 'FTT'
    and blockchain = 'ethereum'

---Query Holder Numbers and total supply
with transfer_detail as (
    select evt_block_time,
        evt_tx_hash,
        contract_address,
        "to" as address,
        cast(value as decimal(38, 0)) as amount
    from erc20_ethereum.evt_Transfer
    where contract_address = 0x50d1c9771902476076ecfc8b2a83ad6b9355a4c9
    
    union all
    
    select evt_block_time,
        evt_tx_hash,
        contract_address,
        "from" as address,
        -1 * cast(value as decimal(38, 0)) as amount
    from erc20_ethereum.evt_Transfer
    where contract_address = 0x50d1c9771902476076ecfc8b2a83ad6b9355a4c9
),

address_balance as (
    select address,
        sum(amount) as balance_amount
    from transfer_detail
    group by address
)

select count(*) as holder_count,
    sum(balance_amount / 1e18) as supply_amount
from address_balance
where balance_amount > 0

---Query Most Holder of Tokens
address_balance as (
    select address,
        sum(amount / 1e18) as balance_amount
    from transfer_detail
    group by address
)

select address,
    balance_amount
from address_balance
order by 2 desc
limit 100

---Query Distribution of Various Holders
select (case when balance_amount >= 10000 then '>= 10000'
            when balance_amount >= 1000 then '>= 1000'
            when balance_amount >= 500 then '>= 500'
            when balance_amount >= 100 then '>= 100'
            when balance_amount >= 10 then '>= 10'
            when balance_amount >= 1 then '>= 1'
            else '< 1.0'
        end) as amount_area_type,
        (case when balance_amount >= 10000 then 10000
            when balance_amount >= 1000 then 1000
            when balance_amount >= 500 then 500
            when balance_amount >= 100 then 100
            when balance_amount >= 10 then 10
            when balance_amount >= 1 then 1
            else 0
        end) as amount_area_id,
    count(address) as holder_count,
    avg(balance_amount) as average_balance_amount
from address_balance
group by 1, 2
order by 2 desc

---Query variation by Date of a token
with transfer_detail as (
    select evt_block_time,
        "to" as address,
        cast(value as decimal(38, 0)) as value,
        evt_tx_hash
    from ftt_ethereum.FTT_Token_evt_Transfer
    
    union all
    
    select evt_block_time,
        "from" as address,
        -1 * cast(value as decimal(38, 0)) as value,
        evt_tx_hash
    from ftt_ethereum.FTT_Token_evt_Transfer
),

holder_balance_weekly as (
    select date_trunc('week', evt_block_time) as block_date,
        address,
        sum(value/1e18) as balance_amount
    from transfer_detail
    group by 1, 2
),

holder_summary_weekly as (
    select block_date,
        address,
        sum(balance_amount) over (partition by address order by block_date) as balance_amount
    from holder_balance_weekly
    order by 1, 2
),

min_max_date as (
    select min(block_date) as start_date,
        max(block_date) as end_date
    from holder_balance_weekly
),

date_series as (
    SELECT dt.block_date 
    FROM min_max_date as mm
    CROSS JOIN unnest(sequence(date(mm.start_date), date(mm.end_date), interval '7' day)) AS dt(block_date)
),

holder_balance_until_date as (
    select distinct d.block_date,
        w.address,
        -- get the last balance of same address on same date or before (when no date on same date)
        first_value(balance_amount) over (partition by w.address order by w.block_date desc) as last_balance_amount
    from date_series d
    inner join holder_summary_weekly w on w.block_date <= d.block_date
),

holder_count_summary as (
    select block_date,
        count(address) as holder_count,
        sum(last_balance_amount) as balance_amount
    from holder_balance_until_date
    where last_balance_amount > 0
    group by block_date
)

select block_date,
    holder_count,
    balance_amount,
    (holder_count - lag(holder_count, 1) over (order by block_date)) as holder_count_change,
    (balance_amount - lag(balance_amount, 1) over (order by block_date)) as balance_amount_change
from holder_count_summary
order by block_date

---Query amount of an specific account


---Query Holders of ETH