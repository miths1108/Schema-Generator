select
	shipmode,
	sum(case
		when orderpriority = '1-URGENT'
			or orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when orderpriority <> '1-URGENT'
			and orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	orders o,
	lineitem l
where
	o.orderkey = l.orderkey
	and shipmode in ('MAIL','SHIP')
	and commitdate < receiptdate
	and shipdate < commitdate
	and receiptdate >= '1994-01-01'
	and receiptdate < dateadd(mm, 1, cast('1995-09-01' as date))
group by
	shipmode
order by
	shipmode;
