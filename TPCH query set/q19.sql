select
	sum(extendedprice* (1 - discount)) as revenue
from
	lineitem l,
	part p
where
	(
		p.partkey = l.partkey
		and brand = 'Brand#12'
		and container in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
		and quantity >= 1 and quantity <= 1 + 10
		and size between 1 and 5
		and shipmode in ('AIR', 'AIR REG')
		and shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p.partkey = l.partkey
		and brand = 'Brand#23'
		and container in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
		and quantity >= 10 and quantity <= 10 + 10
		and size between 1 and 10
		and shipmode in ('AIR', 'AIR REG')
		and shipinstruct = 'DELIVER IN PERSON'
	)
	or
	(
		p.partkey = l.partkey
		and brand = 'Brand#34'
		and container in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
		and quantity >= 20 and quantity <= 20 + 10
		and size between 1 and 15
		and shipmode in ('AIR', 'AIR REG')
		and shipinstruct = 'DELIVER IN PERSON'
	);
