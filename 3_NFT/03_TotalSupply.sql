with total_volume as(
    SELECT
        sum(amount_original) as "Total Trade Volume(ETH)", --总成交量ETH
        sum(amount_usd) as "Total Trade Volume(USD)",      --总成交量USD
        count(amount_original) as "Total Trade Tx"         --总交易笔数
    FROM nft.trades
    WHERE nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        -- AND currency_symbol IN ('ETH', 'WETH') 
),

total_fee as (
    select 
        sum(royalty_fee_amount) as "Total Royalty Fee(ETH)",      --总版权税ETH
        sum(royalty_fee_amount_usd) as "Total Royalty Fee(USD)",  --总版权税USD
        sum(platform_fee_amount) as "Total Platform Fee(ETH)",    --总平台抽成ETH
        sum(platform_fee_amount_usd) as "Total Platform Fee(USD)" --总平台抽成USD
    from nft.fees 
    WHERE nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
    -- AND royalty_fee_currency_symbol IN ('ETH', 'WETH') 
)

select * from total_volume, total_fee