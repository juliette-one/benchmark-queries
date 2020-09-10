-- optimized Postgres ddl's

CREATE TABLE lineorder
(
	lo_orderkey int4 NOT NULL,
	lo_linenumber int4 NOT NULL,
	lo_custkey int4 NOT NULL,
	lo_partkey int4 NOT NULL,
	lo_suppkey int4 NOT NULL,
	lo_orderdate int4 NOT NULL,
	lo_orderpriority varchar(15) NOT NULL,
	lo_shippriority varchar(1) NOT NULL,
	lo_quantity int4 NOT NULL,
	lo_extendedprice int4 NOT NULL,
	lo_ordertotalprice int4 NOT NULL,
	lo_discount int4 NOT NULL,
	lo_revenue int4 NOT NULL,
	lo_supplycost int4 NOT NULL,
	lo_tax int4 NOT NULL,
	lo_commitdate int4 NOT NULL,
	lo_shipmode varchar(10) NOT NULL
) PARTITION BY RANGE (lo_orderdate);


CREATE TABLE lineorder_y1992 PARTITION OF lineorder
FOR VALUES FROM (19920101) TO (19930101);

CREATE TABLE lineorder_y1993 PARTITION OF lineorder
FOR VALUES FROM (19930101) TO (19940101);

CREATE TABLE lineorder_y1994 PARTITION OF lineorder
FOR VALUES FROM (19940101) TO (19950101);

CREATE TABLE lineorder_y1995 PARTITION OF lineorder
FOR VALUES FROM (19950101) TO (19960101);

CREATE TABLE lineorder_y1996 PARTITION OF lineorder
FOR VALUES FROM (19960101) TO (19970101);

CREATE TABLE lineorder_y1997 PARTITION OF lineorder
FOR VALUES FROM (19970101) TO (19980101);

CREATE TABLE lineorder_y1998 PARTITION OF lineorder
FOR VALUES FROM (19980101) TO (19990101);

CREATE INDEX ON lineorder_y1992 (lo_orderdate);
CREATE INDEX ON lineorder_y1993 (lo_orderdate);
CREATE INDEX ON lineorder_y1994 (lo_orderdate);
CREATE INDEX ON lineorder_y1995 (lo_orderdate);
CREATE INDEX ON lineorder_y1996 (lo_orderdate);
CREATE INDEX ON lineorder_y1997 (lo_orderdate);
CREATE INDEX ON lineorder_y1998 (lo_orderdate);