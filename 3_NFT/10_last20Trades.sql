with last_nft_trades as (
    select block_time,
        token_id,
        number_of_items,
        amount_usd,
        seller,
        buyer,
        amount_raw / 1e18 as eth_amount,
        tx_hash
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
    and block_time > now() - interval '90' day
    order by block_time desc
    limit 20
),

floor_price_data as (
    select min(eth_amount / number_of_items) as floor_price_eth,
        max(eth_amount / number_of_items) as ceil_price_eth
    from last_nft_trades
)

select *
from last_nft_trades
join floor_price_data on true
