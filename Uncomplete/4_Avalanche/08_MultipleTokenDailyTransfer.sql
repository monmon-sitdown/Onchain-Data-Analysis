with token_mapping(avax_contract_address, eth_token_address, eth_token_symbol) as (
    values 
    ('0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab', '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2', 'WETH'),
    ('0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664', '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48', 'USDC'),
    ('0x50b7545627a5162f82a992c33b87adc75187b218', '0x2260fac5e5542a773aa44fbcfedf7c193bc2c599', 'WBTC'),
    ('0xd586e7f844cea2f87f50152665bcbc2c279d8d70', '0x6b175474e89094c44da98b954eedeac495271d0f', 'DAI'),
    ('0xc7198437980c041c805a1edcba50c1ce5db95118', '0xdac17f958d2ee523a2206206994597c13d831ec7', 'USDT')
),

token_transfer_details as (
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic3 as varchar), 40)) as account,
        tx_hash,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as deposit_amount,
        0 as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab   -- WETH
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Deposit

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic2 as varchar), 40)) as account,
        tx_hash,
        0 as deposit_amount,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab   -- WETH
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic3 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Withdraw

    union all

    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic3 as varchar), 40)) as account,
        tx_hash,
         bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as deposit_amount,
        0 as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664   -- USDC
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Deposit

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic2 as varchar), 40)) as account,
        tx_hash,
        0 as deposit_amount,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664   -- USDC
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic3 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Withdraw

    union all

    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic3 as varchar), 40)) as account,
        tx_hash,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as amount,
        0 as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0x50b7545627a5162f82a992c33b87adc75187b218  -- WBTC
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Deposit

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic2 as varchar), 40)) as account,
        tx_hash,
        0 as deposit_amount,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0x50b7545627a5162f82a992c33b87adc75187b218   -- WBTC
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic3 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Withdraw

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic3 as varchar), 40)) as account,
        tx_hash,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as deposit_amount,
        0 as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xd586e7f844cea2f87f50152665bcbc2c279d8d70   -- DAI
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Deposit

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic2 as varchar), 40)) as account,
        tx_hash,
        0 as deposit_amount,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xd586e7f844cea2f87f50152665bcbc2c279d8d70   -- DAI
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic3 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Withdraw

    union all

    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic3 as varchar), 40)) as account,
        tx_hash,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as deposit_amount,
        0 as withdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xc7198437980c041c805a1edcba50c1ce5db95118   -- USDT
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic2 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Deposit

    union all
    
    select block_time,
        contract_address,
        concat('0x', "right"(cast(topic2 as varchar), 40)) as account,
        tx_hash,
        0 as deposit_amount,
        bytearray_to_integer(substring(cast(data as varchar), 3, 64)) as widthdraw_amount
    from avalanche_c.logs 
    where contract_address = 0xc7198437980c041c805a1edcba50c1ce5db95118   -- USDT
        and topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef   -- Transfer
        and topic3 = 0x0000000000000000000000000000000000000000000000000000000000000000   -- Withdraw
),

token_transfer_summary as (
    select date_trunc('day', block_time) as block_date,
        contract_address,
        sum(deposit_amount) as deposit_amount,
        sum(withdraw_amount) as withdraw_amount
    from token_transfer_details
    group by 1, 2
    order by 1, 2
),

token_price as (
    select contract_address,
        price,
        decimals
    from (
        select contract_address,
            minute,
            price,
            decimals,
            row_number() over (partition by contract_address order by minute desc) as row_num
        from prices.usd
        where blockchain = 'ethereum'
            and minute > now() - interval '24' hour
            and cast(contract_address as varchar) in (select eth_token_address from token_mapping)
    ) t
    where row_num = 1
)

select s.block_date,
    m.eth_token_symbol,
    s.deposit_amount / power(10, p.decimals) * p.price as deposit_amount_usd,
    s.withdraw_amount / power(10, p.decimals) * p.price as withdraw_amount_usd,
    (s.deposit_amount - s.withdraw_amount) / power(10, p.decimals) * p.price as balance_amount_usd
from token_transfer_summary s
inner join token_mapping m on m.avax_contract_address = cast(s.contract_address as varchar)
inner join token_price p on m.eth_token_address = cast(p.contract_address as varchar)
order by 1, 2
