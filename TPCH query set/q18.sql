select
	name,
	c.custkey,
	o.orderkey,
	orderdate,
	totalprice,
	sum(quantity)
from
	customer c,
	orders o,
	lineitem l
where
	o.orderkey in (
		select
			l2.orderkey
		from
			lineitem l2
		group by
			l2.orderkey having
				sum(quantity) > 300
	)
	and c.custkey = o.custkey
	and o.orderkey = l.orderkey
group by
	name,
	c.custkey,
	o.orderkey,
	orderdate,
	totalprice
order by
	totalprice desc,
	orderdate;
