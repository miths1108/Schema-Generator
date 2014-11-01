select
        sum(extendedprice * discount) as revenue
from
        lineitem
where
        shipdate >=  '1994-01-01' 
        and shipdate < dateadd(yy, 1, cast('1994-01-01' as date))
        and discount between 0.06 - 0.01 and 0.06 + 0.01
        and quantity < 24;

