---Use sign in prices.usd
select * from prices.usd
where symbol = 'WETH'
    and blockchain = 'ethereum'
    and minute >= now() - interval '6' hour
order by minute desc
limit 1

---Use contract address in prices.usd
select * from prices.usd
where contract_address = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2   -- WETH
    and minute >= now() - interval '6' hour
order by minute desc
limit 1

---Read several prices of tokens in prices.usd_latest
select * from prices.usd_latest
where symbol in ('WETH', 'WBTC', 'USDC')
    and blockchain = 'ethereum'

---Read several prices of tokens in prices.usd
select symbol, decimals, price, minute
from (
    select row_number() over (partition by symbol order by minute desc) as row_num, *
    from prices.usd
    where symbol in ('WETH', 'WBTC', 'USDC')
        and blockchain = 'ethereum'
        and minute >= now() - interval '6' hour
    order by minute desc
) p
where row_num = 1

---Query Average Daily Price of ERC20 
select date_trunc('day', minute) as block_date,
    avg(price) as price
from prices.usd
where symbol = 'WETH'
    and blockchain = 'ethereum'
    and minute >= date('2023-01-01')
group by 1
order by 1

---Query Average Daily Prices of several tokens
select date_trunc('day', minute) as block_date,
    symbol,
    decimals,
    contract_address,
    avg(price) as price
from prices.usd
where symbol in ('WETH', 'WBTC', 'USDC')
    and blockchain = 'ethereum'
    and minute >= date('2022-10-01')
group by 1, 2, 3, 4
order by 2, 1   -- Order by symbol first

