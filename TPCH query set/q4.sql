select
        orderpriority,
        count(*) as order_count
from
        orders o
where
        orderdate >='1993-07-01' 
        and orderdate < dateadd(mm,3, cast('1993-07-01' as date))
        and exists (
                select
                        *
                from
                        lineitem l
                where
                        l.orderkey = o.orderkey
                        and commitdate < receiptdate
        )
group by
        orderpriority
order by
        orderpriority;


