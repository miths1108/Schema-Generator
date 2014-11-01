select
	s.name,
	address
from
	supplier s,
	nation n
where
	suppkey in (
		select
			ps.suppkey
		from
			partsupp ps
		where
			ps.partkey in (
				select
					p.partkey
				from
					part p
				where
					p.name like 'forest%%'
			)
			and availqty > (
				select
					0.5 * sum(quantity)
				from
					lineitem l
				where
					l.partkey = ps.partkey
					and l.suppkey = ps.suppkey
					and shipdate >= 1994-01-01
					and shipdate < dateadd(yy,1,'1994-01-01')
			)
	)
	and s.nationkey = n.nationkey
	and n.name = 'CANADA'
order by
	s.name;
