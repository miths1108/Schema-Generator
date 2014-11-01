select
        n.name,
        sum(extendedprice * (1 - discount)) as revenue
from
        customer c,
        orders o,
        lineitem l,
        supplier s,
        nation n,
        region r
where
        c.custkey = o.custkey
        and l.orderkey = o.orderkey
        and l.suppkey = s.suppkey
        and c.nationkey = s.nationkey
        and s.nationkey = n.nationkey
        and n.regionkey = r.regionkey
        and r.name = 'ASIA'
        and orderdate >= '1994-01-01' 
        and orderdate < dateadd(YY, 1, cast('1994-01-01' as date))
group by
        n.name
order by
        revenue desc;

