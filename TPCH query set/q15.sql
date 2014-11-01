create view revenue:s (supplier_no, total_revenue) as
	select
		suppkey,
		sum(extendedprice * (1 - discount))
	from
		lineitem
	where
		shipdate >= date ':1'
		and shipdate < date ':1' + interval '3' month
	group by
		suppkey;

select
	suppkey,
	name,
	address,
	phone,
	total_revenue
from
	supplier,
	revenue:s
where
	suppkey = supplier_no
	and total_revenue = (
		select
			max(total_revenue)
		from
			revenue:s
	)
order by
	suppkey;

drop view revenue:s;