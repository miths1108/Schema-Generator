select
	sum(extendedprice) / 7.0 as avg_yearly
from
	lineitem l,
	part p
where
	p.partkey = l.partkey
	and brand = 'Brand#23'
	and container = 'MED BOX'
	and quantity < (
		select
			0.2 * avg(quantity)
		from
			lineitem l2
		where
			l2.partkey = p.partkey
	);
