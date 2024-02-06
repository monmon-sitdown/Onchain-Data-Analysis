select date_trunc('day', minute) as dt, 
AVG(price) as price
from prices.usd where symbol = 'AVAX' group by 1