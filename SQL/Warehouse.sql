DECLARE @Databasename VARCHAR(128) = 'WarehouseDB';
IF NOT EXISTS(select 1 FROM sys.databases where name= @Databasename)
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename);
	EXEC sp_executesql @SQL;
END

USE WarehouseDB;

--DROP TABLE [dbo].fmcg;

CREATE TABLE [dbo].fmcg (
    Ware_house_ID VARCHAR(20),
    WH_Manager_ID VARCHAR(20),
    Location_type VARCHAR(20),
    WH_capacity_size VARCHAR(20),
    zone VARCHAR(20),
    WH_regional_zone VARCHAR(20),
    num_refill_req_l3m INT,
    transport_issue_l1y INT,
    Competitor_in_mkt INT,
    retail_shop_num INT,
    wh_owner_type VARCHAR(20),
    distributor_num INT,
    flood_impacted INT,
    flood_proof INT,
    electric_supply INT,
    dist_from_hub INT,
    workers_num INT,
    wh_est_year INT,
    storage_issue_reported_l3m INT,
    temp_reg_mach INT,
    approved_wh_govt_certificate VARCHAR(20),
    wh_breakdown_l3m INT,
    govt_check_l3m INT,
    product_wg_ton INT
);

BULK INSERT fmcg FROM 'D:/FMCG_data.csv'
WITH 
(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2		--skip the header from the records
);

SELECT * FROM fmcg;

--1.Show Number of records
select count(*) as Num_Of_Records from fmcg;

--2.Write query to find Warehouse with Minimum Capacity(product_weight) of Storage (Top 5)
select top(5) Ware_house_ID, product_wg_ton from fmcg order by product_wg_ton DESC;

--3.Write query to find Warehouse with Maximum Capacity(product_weight) of Storage (Bottom 5)
select top(5) Ware_house_ID, product_wg_ton from fmcg order by product_wg_ton ASC;

--4.Find the Total number if WH Regional Zone Count of each category
select WH_regional_zone,count(*) as Count_of_Zone from fmcg 
group by WH_regional_zone 
order by WH_regional_zone asc;

--5.Find avg,min,max,median warehouse with minimum capacity 10000 
--and location type Urban
with warehouse as(
	select dist_from_hub,PERCENTILE_CONT(0.5) within group (order by dist_from_hub)
	over() as MEDIAN 
	from fmcg
	where Location_type='Urban' and product_wg_ton> 10000
)
select avg(dist_from_hub) as average,
	   min(dist_from_hub) as minimum,
	   max(dist_from_hub) as maximum,
(select distinct median from warehouse) as median
from fmcg where Location_type='Urban' and product_wg_ton> 10000;

--6.Window Function - In SQL server window function performs calculaton across set of 
--table rows. Unlike aggregate functions which returns a single value for group of rows,
--window functions returns a value for each row in result set.

select * from fmcg;
--Rank function

select Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,
rank() over(partition by Competitor_in_mkt order by product_wg_ton desc)
as wh_rank from fmcg;

--Same values for same category returns same rank
select Ware_house_ID,product_wg_ton,zone,dist_from_hub,
rank() over(partition by zone order by dist_from_hub)
as wh_rank from fmcg;

--Dense rank
select Ware_house_ID,product_wg_ton,zone,dist_from_hub,
dense_rank() over(partition by zone order by dist_from_hub)
as wh_rank from fmcg;

--Show Top 5 rank from each category
--Using CTE
with rankCTE as(
	select 
		Ware_house_ID,
		Location_type,
		zone,
		wh_owner_type,
		product_wg_ton,
		Competitor_in_mkt,
	rank() over(partition by Competitor_in_mkt order by product_wg_ton desc)
	as wh_rank from fmcg
	)
select * from rankCTE where wh_rank<=5;

--Using subquery
select * from (
	select Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,
	rank() over(partition by Competitor_in_mkt order by product_wg_ton desc)
	as wh_rank from fmcg)
as regional_table where wh_rank<=5; 

--Show Top 5 Rows
select top(5) * from(
	select Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,
	rank() over(partition by Competitor_in_mkt order by product_wg_ton desc)
	as wh_rank from fmcg)
as regional_table;

--Lag & Lead

--Shows previous value for the current row
select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	lag(product_wg_ton,1) over(partition by zone order by workers_num desc)
	as previous_product_wg_ton 
from fmcg;

--Shows next value for the current row
select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	lead(product_wg_ton,1) over(partition by zone order by workers_num desc)
	as next_product_wg_ton 
from fmcg;

--NTILE - Distribute each row into groups
select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	ntile(5) over(order by product_wg_ton asc) 
	as five_percentiles
from fmcg;

--Finds percentile values betweeen 0 and 1
select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	percent_rank() over(order by workers_num asc) 
	as percentiles
from fmcg where workers_num>=0;

--Show all records where number of workers comes in range(0th to 40th percentile).
select * from(
	select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	percent_rank() over(order by workers_num asc) 
	as percentiles
	from fmcg where workers_num>=0
)as percentile_table where percentiles<=0.40;

--Find the Difference between current value of product_wg_ton and compare it with previous two values
--Lag(2) and rank overall records as per differences.

with lagCTE as(
	select 
	Ware_house_ID,Location_type,zone,wh_owner_type,product_wg_ton,Competitor_in_mkt,workers_num,
	product_wg_ton-lag(product_wg_ton,2) over(order by product_wg_ton)
	as difference_of_product_wg_ton
	from fmcg
)select *,
rank() over(order by difference_of_product_wg_ton desc) as rank 
from lagCTE where difference_of_product_wg_ton >=0;


