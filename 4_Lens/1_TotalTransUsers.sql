---Lens Total Transactions and Users
select count(*) as transaction_count,
    count(distinct "from") as user_count    -- count unique users
from polygon.transactions
where "to" = 0xdb46d1dc155634fbc732f92e853b10b288ad5a1d   -- LensHub
    and block_time >= date('2022-05-16')  -- contract creation date


