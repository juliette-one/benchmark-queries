CREATE TABLE IF NOT EXISTS optimized.part
(
p_partkey INTEGER NOT NULL  ENCODE az64 sortkey
,p_name VARCHAR(22) NOT NULL  ENCODE zstd
,p_mfgr VARCHAR(6) NOT NULL  ENCODE zstd
,p_category VARCHAR(7) NOT NULL  ENCODE zstd
,p_brand1 VARCHAR(9) NOT NULL  ENCODE zstd
,p_color VARCHAR(11) NOT NULL  ENCODE bytedict
,p_type VARCHAR(25) NOT NULL  ENCODE bytedict
,p_size INTEGER NOT NULL  ENCODE az64
,p_container VARCHAR(10) NOT NULL  ENCODE bytedict
)
DISTSTYLE ALL;

INSERT INTO optimized.part
(SELECT * FROM vanilla.part);

--########################

CREATE TABLE IF NOT EXISTS optimized.supplier
(
s_suppkey INTEGER NOT NULL  ENCODE az64 sortkey
,s_name VARCHAR(25) NOT NULL  ENCODE zstd
,s_address VARCHAR(25) NOT NULL  ENCODE zstd
,s_city VARCHAR(10) NOT NULL  ENCODE bytedict
,s_nation VARCHAR(15) NOT NULL  ENCODE bytedict
,s_region VARCHAR(12) NOT NULL  ENCODE bytedict
,s_phone VARCHAR(15) NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
;

INSERT INTO optimized.supplier
(SELECT * FROM vanilla.supplier);

--#############################


CREATE TABLE optimized.customer (
  c_custkey     integer        not NULL ENCODE az64 sortkey, 
  c_name        varchar(25)    not NULL encode zstd,
  c_address     varchar(25)    not NULL encode zstd,
  c_city        varchar(10)    not NULL encode bytedict,
  c_nation      varchar(15)    not NULL encode bytedict,
  c_region      varchar(12)    not NULL encode bytedict,
  c_phone       varchar(15)    not NULL encode zstd,
  c_mktsegment      varchar(10)    not NULL encode bytedict)
diststyle all;

INSERT INTO optimized.customer
(SELECT * FROM vanilla.customer);


--#############################


CREATE TABLE IF NOT EXISTS optimized.dwdate
(
d_datekey INTEGER NOT NULL  ENCODE az64 
,d_date VARCHAR(19) NOT NULL  ENCODE zstd
,d_dayofweek VARCHAR(10) NOT NULL  ENCODE zstd
,d_month VARCHAR(10) NOT NULL  ENCODE zstd
,d_year INTEGER NOT NULL  ENCODE az64 
,d_yearmonthnum INTEGER NOT NULL  ENCODE az64
,d_yearmonth VARCHAR(8) NOT NULL  ENCODE zstd
,d_daynuminweek INTEGER NOT NULL  ENCODE az64
,d_daynuminmonth INTEGER NOT NULL  ENCODE az64
,d_daynuminyear INTEGER NOT NULL  ENCODE az64
,d_monthnuminyear INTEGER NOT NULL  ENCODE az64
,d_weeknuminyear INTEGER NOT NULL  ENCODE az64
,d_sellingseason VARCHAR(13) NOT NULL  ENCODE zstd
,d_lastdayinweekfl VARCHAR(1) NOT NULL  ENCODE zstd
,d_lastdayinmonthfl VARCHAR(1) NOT NULL  ENCODE zstd
,d_holidayfl VARCHAR(1) NOT NULL  ENCODE zstd
,d_weekdayfl VARCHAR(1) NOT NULL  ENCODE zstd
)
DISTSTYLE ALL
interleaved sortkey (d_datekey, d_year);
;

INSERT INTO optimized.dwdate
(SELECT * FROM vanilla.dwdate);


--###################
CREATE TABLE optimized.lineorder (
  lo_orderkey          integer     not NULL encode AZ64,
  lo_linenumber        integer     not NULL encode AZ64,
  lo_custkey           integer     not NULL encode AZ64,
  lo_partkey           integer     not NULL encode AZ64,
  lo_suppkey           integer     not NULL  encode AZ64,
  lo_orderdate         integer     not null encode AZ64,
  lo_orderpriority     varchar(15)     not NULL encode zstd,
  lo_shippriority      varchar(1)      not null encode zstd,
  lo_quantity          integer     not NULL encode AZ64,
  lo_extendedprice     integer     not null encode AZ64,
  lo_ordertotalprice   integer     not null encode AZ64,
  lo_discount          integer     not null encode AZ64,
  lo_revenue           integer     not null encode AZ64,
  lo_supplycost        integer     not null encode AZ64,
  lo_tax               integer     not null encode AZ64,
  lo_commitdate         integer         not null encode AZ64,
  lo_shipmode          varchar(10)     not NULL encode bytedict
)
DISTSTYLE EVEN
interleaved sortkey (lo_orderdate, lo_custkey, lo_partkey, lo_suppkey);


INSERT INTO optimized.lineorder
(SELECT * FROM vanilla.lineorder);

--#########################
