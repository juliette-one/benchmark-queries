-- Query 1:
-- Joins, group by and ranges

SELECT 
	sum(lo_extendedprice*lo_discount) AS revenue
FROM lineorder, dwdate 
WHERE lo_orderdate = d_datekey 
	AND d_year = 1997 
	AND lo_discount BETWEEN 1 AND 3 
	AND lo_quantity < 24;

-- Query 2:
-- Joins, specific values, group by and ordering
SELECT 
	sum(lo_revenue)
	, d_year
	, p_brand1 
FROM lineorder, dwdate, part, supplier
WHERE 
	lo_orderdate = d_datekey 
	AND lo_partkey = p_partkey 
	AND lo_suppkey = s_suppkey 
	AND p_category = 'MFGR#12' 
	AND s_region = 'AMERICA'
GROUP BY d_year, p_brand1
ORDER BY d_year, p_brand1;

-- Query 3:
-- Joins, multi-choice, specific values, group by and multi ordering
SELECT 
	c_city
	, s_city
	, d_year
	, sum(lo_revenue) AS revenue 
FROM customer, lineorder, supplier, dwdate
WHERE 
	lo_custkey = c_custkey 
	AND  lo_suppkey = s_suppkey 
	AND lo_orderdate = d_datekey 
	AND (c_city='UNITED KI1' or c_city='UNITED KI5') 
	AND (s_city='UNITED KI1' or s_city='UNITED KI5') 
	AND d_yearmonth = 'Dec1997'
GROUP BY c_city, s_city, d_year
ORDER BY d_year ASC, revenue DESC;

--Query 4:
-- joins, no selections, group by
SELECT c.c_name, d.d_yearmonthnum, sum(lo.lo_revenue)
FROM lineorder lo, customer c, dwdate d
WHERE lo.lo_orderdate = d.d_datekey AND lo.lo_custkey = c.c_custkey
GROUP BY c.c_name, d.d_yearmonthnum;

--Query 5:
-- joins, subqueries, partitioning, group by's, ranges, the works
SELECT 
	sub2.* FROM (
		SELECT 
			sub.c_name
			, sub.d_yearmonthnum
			, sub.d_year
			, sub.TotalMonthRevenue
			, ROW_NUMBER () OVER (PARTITION BY sub.d_yearmonthnum ORDER BY sub.TotalMonthRevenue DESC) as RevenueRank
		FROM (
			SELECT 
				c.c_name
				, d.d_yearmonthnum
				, d.d_year
				, SUM(lo.lo_revenue) as TotalMonthRevenue 
			FROM lineorder lo, customer c, dwdate d 
			WHERE 
				lo.lo_orderdate = d.d_datekey 
				AND lo.lo_custkey = c.c_custkey 
				AND d.d_year = 1997 
			GROUP BY c.c_name, d.d_year, d.d_yearmonthnum
		) sub
	) sub2
WHERE RevenueRank <= 10
