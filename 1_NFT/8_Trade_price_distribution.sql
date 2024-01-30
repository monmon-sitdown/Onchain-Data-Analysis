with nft_trade_details as (
    select block_time, amount_raw / 1e18 as amount_eth
    from nft.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and currency_symbol in ('ETH', 'WETH')
        and block_time >= now() - interval '30 days'
),

data_bin as (
    select block_time,
        amount_eth,
        PERCENT_RANK() over(order by amount_eth)  as bucket
    from nft_trade_details
)

select * from data_bin