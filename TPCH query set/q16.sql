select
	brand,
	type,
	size,
	count(distinct ps_suppkey) as supplier_cnt
from
	partsupp ps,
	part p
where
	p.partkey = ps.partkey
	and brand <> 'Brand#45'
	and type not like 'MEDIUM POLISHED%%'
	and size in (49, 14, 23, 45, 19, 3, 36, 9) 
	and ps.suppkey not in (
		select
			s.suppkey
		from
			supplier s
		where
			s.comment like '%Customer%Complaints%'
	)
group by
	brand,
	type,
	size
order by
	supplier_cnt desc,
	brand,
	type,
	size;
