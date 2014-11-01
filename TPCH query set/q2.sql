select
        acctbal,
        s.name,
        n.name,
        p.partkey,
        mfgr,
        address,
        phone,
        s.comment
from
        part p,
        supplier s,
        partsupp ps,
        nation n,
        region r
where
        p.partkey = ps.partkey
        and s.suppkey = ps.suppkey
        and size = 15
        and type like '%%BRASS'
        and s.nationkey = n.nationkey
        and n.regionkey = r.regionkey
        and r.name = 'EUROPE' 
        and supplycost = (
                select
                        min(supplycost)
                from
                        partsupp ps1,
                        supplier s1,
                        nation n1,
                        region r1
                where
                        p.partkey = ps1.partkey
                        and s1.suppkey = ps1.suppkey
                        and s1.nationkey = n1.nationkey
                        and n1.regionkey = r1.regionkey
                        and r1.name = 'EUROPE' 
        )
order by
        acctbal desc,
        n.name,
        s.name,
        ppartkey;


