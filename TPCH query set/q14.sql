select
	100.00 * sum(case
		when type like 'PROMO%'
			then extendedprice * (1 - discount)
		else 0
	end) / sum(extendedprice * (1 - discount)) as promo_revenue
from
	lineitem l,
	part p
where
	l.partkey = p.partkey
	and shipdate >=  '1995-09-01'
	and shipdate < dateadd(mm, 1, '1995-09-01')
