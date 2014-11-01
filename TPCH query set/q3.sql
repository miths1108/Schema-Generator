select
        l.orderkey,
        sum(extendedprice * (1 - discount)) as revenue,
        orderdate,
        shippriority
from
        customer c,
        orders o,
        lineitem l
where
        mktsegment = 'BUILDING'
        and c.custkey = o.custkey
        and l.orderkey = o.orderkey
        and orderdate < '1995-03-15'
        and shipdate > '1995-03-15'
group by
        l.orderkey,
        orderdate,
        shippriority
order by
        revenue desc,
        orderdate;
