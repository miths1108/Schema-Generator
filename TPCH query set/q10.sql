select
	c.custkey,
	c.name,
	sum(extendedprice * (1 - discount)) as revenue,
	acctbal,
	n.name,
	address,
	phone,
	c.comment
from
	customer c,
	orders o,
	lineitem l,
	nation n
where
	c.custkey = o.custkey
	and l.orderkey = o.orderkey
	and orderdate >= '1993-10-01'
	and orderdate < dateadd(mm, 3, cast('1993-10-01' as date))
	and returnflag = 'R'
	and c.nationkey = n.nationkey
group by
	c.custkey,
	c.name,
	acctbal,
	phone,
	n.name,
	address,
	c.comment
order by
	revenue desc;
