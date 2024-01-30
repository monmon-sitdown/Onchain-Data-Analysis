    select date_trunc('minute', block_time) as block_time, 
        number_of_items,
        amount_raw / 1e18 as amount_eth,
        (amount_raw / number_of_items) / 1e18 as price_eth,
        amount_usd,
        amount_usd / number_of_items as price_usd,
        (avg(amount_raw / number_of_items) over ()) / 1e18 as avg_price_eth,
        (avg(amount_raw / number_of_items) over (order by block_time rows between 6 preceding and current row)) / 1e18 as ma_price_eth,
        avg(amount_usd / number_of_items) over () as avg_price_usd
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
    and block_time > now() - interval '24' hour
    order by block_time