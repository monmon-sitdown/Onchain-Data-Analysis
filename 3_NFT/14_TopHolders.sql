with user_trade_details as (
    select block_time,
        buyer as address, 
        cast(number_of_items as integer) as number_of_items
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and block_time > date('2022-01-01')
    
    union all
    
    select block_time,
        seller as address, 
        (-1) * cast(number_of_items as integer) as number_of_items
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and block_time > date('2022-01-01')
    order by block_time
),

nft_holder_summary as (
    select address,
        sum(number_of_items) as hold_token_count
    from user_trade_details
    group by address
    having sum(number_of_items) > 0
    order by 2 desc
    limit 50
),

top_holder_total as (
    select sum(hold_token_count) as top_holder_nft_count
    from nft_holder_summary
)

select row_number() over (order by hold_token_count desc) as rank_id,
    hold_token_count,
    ---'<a href=https://opensea.io/' || address || ' target=_blank>OpenSea Link</a>' as link,
    address,
    top_holder_nft_count
from nft_holder_summary
inner join top_holder_total on true
order by hold_token_count desc
