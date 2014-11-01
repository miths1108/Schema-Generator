select
	nation,
	year,
	sum(amount) as sum_profit
from
	(
		select
			n.name as nation,
			extract(year from orderdate) as year,
			extendedprice * (1 - discount) - supplycost * quantity as amount
		from
			part p,
			supplier s,
			lineitem l,
			partsupp ps,
			orders o,
			nation n
		where
			s.suppkey = l.suppkey
			and ps.suppkey = l.suppkey
			and ps.partkey = l.partkey
			and p.partkey = l.partkey
			and o.orderkey = l.orderkey
			and s.nationkey = n.nationkey
			and p.name like '%%green%%'
	) as profit
group by
	nation,
	year
order by
	nation,
	year desc;
