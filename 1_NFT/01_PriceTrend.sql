with data_bin as (
    --Get all prices, transfer to percentage by percent_rank
    select block_time, amount_original, PERCENT_RANK() over(order by amount_original) as bucket
    from nft.trades
    where block_time > now() - interval '3' year
        and nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and currency_symbol in ('ETH', 'WETH')
)

--- Filter the prices too high or too low by OutlierFloor and OutlierCeil
---select * from data_bin where bucket between '{{OutlierFloor}}' and '{{OutlierCeil}}'
select * from data_bin