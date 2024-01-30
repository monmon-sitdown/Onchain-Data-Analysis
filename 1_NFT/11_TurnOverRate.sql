with nft_mints as (
    select *
    from erc721_ethereum.evt_Transfer
    where contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and `from` = 0x0000000000000000000000000000000000000000
        and evt_block_time > date('2022-01-01')
),

total_mint_count as (
    select count(*) as mint_count
    from nft_mints
),
  
nft_trades as (
    select block_time,
        amount_raw / 1e18 as amount_eth
    from opensea.trades
    where nft_contract_address = 0xed5af388653567af2f388e6224dc7c4b3241c544
        and block_time > date('2022-01-01')
        and token_id in ( select distinct tokenId from nft_mints )
),

trade_count_summary as (
    select date_trunc('day', block_time) as block_date,
      count(1) as trade_count
    from nft_trades
    where amount_eth > 0
    group by 1
    order by 1
)

select block_date,
    s.trade_count * 1.0 / t.mint_count as turnover_rate
from trade_count_summary s
inner join total_mint_count t on true
order by block_date