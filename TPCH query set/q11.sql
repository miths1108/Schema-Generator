select
	partkey,
	sum(supplycost * availqty) as value
from
	partsupp ps,
	supplier s,
	nation n
where
	ps.suppkey = s.suppkey
	and s.nationkey = n.nationkey
	and n.name = 'GERMANY'
group by
	partkey having
		sum(supplycost * availqty) > (
			select
				sum(supplycost * availqty) * 0.0001000000
			from
				partsupp ps,
				supplier s,
				nation n
			where
				ps.suppkey = s.suppkey
				and s.nationkey = n.nationkey
				and n.name = 'GERMANY'
		)
order by
	value desc;
