select
	cntrycode,
	count(*) as numcust,
	sum(acctbal) as totacctbal
from
	(
		select
			substring(phone,1,2) as cntrycode,
			acctbal
		from
			customer c
		where
			substring(phone,1,2) in
				('13', '31', '23', '29', '30', '18', '17')
			and acctbal > (
				select
					avg(acctbal)
				from
					customer
				where
					acctbal > 0.00
					and substring(phone,1,2) in
						('13', '31', '23', '29', '30', '18', '17')
			)
			and not exists (
				select
					*
				from
					orders o
				where
					o.custkey = c.custkey
			)
	) as custsale
group by
	cntrycode
order by
	cntrycode;
