--Case Study - Supply Chain Management
USE WarehouseDB;

--a) Find the Shape of the FMCG Table. 
--Question: How would you determine the total number of rows and 
--columns in the FMCG dataset?
select count(*) as Row_Count from fmcg;
select count(*) as Coloumn_Count from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'fmcg'


--b) Evaluate the Impact of Warehouse Age on Performance. 
-- Question: How does the age of a warehouse impact its operational 
-- performance, specifically in terms of storage issues reported in the 
-- last year?
select (YEAR(GETDATE())- wh_est_year) as WarehouseAge,
avg(storage_issue_reported_l3m) as AvgStorageIssues 
from fmcg 
where wh_est_year is not null group by (YEAR(GETDATE())- wh_est_year)
order by WarehouseAge;
-- Studying the query response we can say there is positive coorelation
--or linearity or direct relation between WarehouseAge and AvyStorageIssues


--c)Analyze the Relationship Between Flood-Proof Status and Transport Issues. 
-- Question: Is there a significant relationship between flood-proof status 
-- and the number of transport issues reported in the last year?
select flood_proof,sum(transport_issue_l1y) as total_transport_issue
from fmcg
group by flood_proof;
--Insight: More transportation issue has been found for non-flood proof warehouses


--d)Evaluate the Impact of Government Certification on Warehouse Performance. 
--Question: How does having a government certification impact the 
--performance of warehouses, particularly in terms of breakdowns 
--and storage issues reported in last 3 months?
select 
	approved_wh_govt_certificate,
	avg(storage_issue_reported_l3m) as AvgStorageIssues,
	avg(wh_breakdown_l3m) total_breakdown
from fmcg
group by approved_wh_govt_certificate
order by approved_wh_govt_certificate;
--Insight: Comparing values of Approved_govt_certificates and sum of breakdowns
--No relation found among all


--e)Determine the Optimal Distance from Hub for Warehouses:
--Question: What is the optimal distance from the hub for warehouses 
--to minimize transport issues, based on the data provided?
select avg(dist_from_hub) as optimal_dist,transport_issue_l1y 
from fmcg
group by transport_issue_l1y
order by transport_issue_l1y;
--Insight: Optimum distance from hub must be less or equal to 162 for no transportation issues.


--f) Identify the Zones with the Most Operational Challenges.
--Question: Which zones face the most operational challenges,considering factors like transport issues, 
--storage problems, and breakdowns?
select 
	zone,
	sum(transport_issue_l1y)as transport_issue,
	sum(storage_issue_reported_l3m)as storage_issue,
	sum(wh_breakdown_l3m) as breakdown,
	(sum(transport_issue_l1y)+sum(storage_issue_reported_l3m)+sum(wh_breakdown_l3m)) as total_issues
from fmcg
group by zone
order by total_issues;

--h)Examine the Effectiveness of Warehouse Distribution Strategy. 
--Question: How effective is the current distribution strategy in each zone, based on the number of 
--distributors connected to warehouses and their respective product weights?
select 
	zone,
	sum(distributor_num) as total_distributors,
	sum(product_wg_ton) total_product_weight,
	sum(product_wg_ton)/sum(distributor_num)
from fmcg
group by zone
order by total_distributors
--Insight: Current Distribution plan is best in east zone and worst in south and west

--g)Identify High-Risk Warehouses Based on Breakdown Incidents and Age. 
--Question: Which warehouses are at high risk of breakdowns, especially considering their age and the number of breakdown 
--incidents reported in the last 3 months?
select 
	Ware_house_ID,
	(YEAR(GETDATE()) - wh_est_year) as Warehouse_Age,
	wh_breakdown_l3m,
case
	when wh_breakdown_l3m >=5 then 'High Risk'
	when wh_breakdown_l3m >=3 then 'Medium Risk'
	else 'Low Risk'
end as Risk_Level
from fmcg 
where (YEAR(GETDATE()) - wh_est_year)>15 
order by wh_breakdown_l3m desc

--i)Correlation Between Worker Numbers and Warehouse Issues. 
--Question: Is there a correlation between the number of workers in a warehouse and the number of storage 
--or breakdown issues reported?
select 
	workers_num,
	avg(storage_issue_reported_l3m) as storage_issue,
	avg(wh_breakdown_l3m) as breakdown_issue
from fmcg
group by workers_num
order by workers_num

--j)Assess the Zone-wise Distribution of Flood Impacted Warehouses.
--Question: Which zones are most affected by flood impacts, and how does this affect their overall operational stability?
select 
	zone,
	count(*) as total_warehouse,
	sum(case 
			when flood_impacted=1 then 1
			else 0
		end) as Flood_impacted_warehouse,
	sum(case 
			when flood_impacted=1 then 1
			else 0
		end)*100/count(*) as Flood_impacted_percentage
from fmcg
group by zone
order by Flood_impacted_percentage desc;
--Insight: Analyzing all zones flood impacted warehouse percentage can be concluded that North zone warehouse is highly
--affected by flood 

--k) Calculate the Cumulative Sum of Total Working Years for Each Zone. 
--Question: How can you calculate the cumulative sum of total working years for each zone?
select 
	zone,
	sum(YEAR(GETDATE())- wh_est_year) 
	over(order by zone rows between unbounded preceding and current row)
	as Cumulative_Age
from fmcg;

select zone,YEAR(GETDATE())-wh_est_year from fmcg order by zone;


--k) Calculate the Cumulative Sum of Total Workers for Each Warehouse Govt Rating 
--Question: Write a query to calculate the cumulative sum of total workers for years for each Warehouse Govt Rating
select 
	approved_wh_govt_certificate,workers_num,
	sum(workers_num) 
	over(partition by approved_wh_govt_certificate order by approved_wh_govt_certificate rows between unbounded preceding and current row)
	as Cumulative_sum
from fmcg;

--l)Rank Warehouses Based on Distance from the Hub. 
--Question: How would you rank warehouses based on their distance from the hub?
select 
	Ware_house_ID,
	dist_from_hub,
	dense_rank() over(order by dist_from_hub) as rank
from fmcg;

--m) Calculate the Running(Cumulative,Moving) Average of Product Weight in Tons for Each Zone:
--Question: How can you calculate the running total of product weight in tons for each zone?
select 
	zone,
	product_wg_ton,
	avg(product_wg_ton)
	over(partition by zone order by zone rows between unbounded preceding and current row)
	as running_avg
from fmcg;

--n)Rank Warehouses Based on Total Number of Breakdown Incidents. 
--Question: How can you rank warehouses based on the total number of breakdown incidents in the last 3 months?
select 
	Ware_house_ID,
	wh_breakdown_l3m,
	dense_rank() over(order by wh_breakdown_l3m) as rank
from fmcg;

--o)Determine the Relation Between Transport Issues and Flood Impact.
--Question: Is there any significant relationship between the number of transport issues and flood impact status of warehouses?
select 
	flood_impacted,
	sum(transport_issue_l1y) as transport_issues
from fmcg
group by flood_impacted

--q) Window Functions: RANK, DENSE_RANK, LAG, LEAD
--Rank Warehouses by Product Weight within Each Zone:
--Question: How do you rank warehouses based on the product weight they handle within each zone,
--allowing ties?
select 
	Ware_house_ID,
	zone,
	product_wg_ton,
	dense_rank() over(partition by zone order by product_wg_ton desc) as product_rank
from fmcg

--r) Determine the Most Efficient Warehouses Using DENSE_RANK. 
select
	Ware_house_ID,
	transport_issue_l1y,
	storage_issue_reported_l3m,
	wh_breakdown_l3m,
	dist_from_hub,
	DENSE_RANK() over(order by transport_issue_l1y,storage_issue_reported_l3m,wh_breakdown_l3m,
	dist_from_hub) as rank
from fmcg
--Question: How can you use DENSE_RANK to find the most efficient warehouses in terms of 
--breakdown incidents within each zone?
select
	zone,
	wh_breakdown_l3m,
	dense_rank() over(partition by zone order by wh_breakdown_l3m) as rank
from fmcg;

--s) Calculate the Difference in Storage Issues Using LAG.
--Question: How can you use LAG to calculate the difference in storage issues reported between 
--consecutive warehouses within each zone?
select 
	Ware_house_ID,
	storage_issue_reported_l3m,
	LAG(storage_issue_reported_l3m,1,0) over(partition by zone order by Ware_house_ID) 
	as previous_storage_issue,
	storage_issue_reported_l3m - LAG(storage_issue_reported_l3m,1,0) over(partition by zone 
	order by Ware_house_ID) as difference_in_issue
from fmcg

--t) Compare Current and Next Warehouse's Distance Using LEAD:
--Question: How can you compare the distance from the hub of the current warehouse to the next one using LEAD?
select 
	Ware_house_ID,
	dist_from_hub,
	LEAD(dist_from_hub,1,0) over(order by Ware_house_ID) as next_dist_from_hub,
	dist_from_hub-LEAD(dist_from_hub,1,0) over(order by Ware_house_ID) as differences_in_hub
from fmcg

--u)Calculate Cumulative Total of Product Weight by Zone
--Question: How can you calculate the cumulative total of product weight handled by warehouses within each zone?

--v)Categorize Warehouses by Product Weight. 
--Question: How can you categorize warehouses as 'Low', 'Medium', or 'High' based on the amount of product weight they handle?
select 
	Ware_house_ID,
	product_wg_ton,
	case
		when product_wg_ton< 10000 then 'low'
		when product_wg_ton >20000 then 'high'
		else 'medium'
	end as risk_category
from fmcg

select 
	Ware_house_ID,
	product_wg_ton,
	case when Tile = 3 then 'High'
		 when Tile = 2 then 'Medium'
		 else 'Low'
	end as Category 
from( select Ware_house_ID, product_wg_ton,NTILE(3) over(order by product_wg_ton) as Tile from fmcg) as TileCTE
order by Ware_house_ID

--w)Create a Stored Procedure to Fetch High-Risk Warehouses:
--Question: How would you create a stored procedure that returns all warehouses classified as 'High Risk' 
--based on the number of breakdowns and storage issues?
create procedure HighRiskWarehouse 
as
begin
	select 
		Ware_house_ID, 
		transport_issue_l1y,
		storage_issue_reported_l3m,
		wh_breakdown_l3m
	from fmcg
	where 
		(storage_issue_reported_l3m > 10 or wh_breakdown_l3m > 5) and transport_issue_l1y>0
end;

--Execute Stored Procedure
exec HighRiskWarehouse

--x) Create a Stored Procedure to Calculate Warehouse Efficiency:
--Question: How would you create a stored procedure to calculate and return the efficiency of each warehouse 
--based on its product weight and number of distributors?
create procedure WarehouseEffc
as
begin
	select
		Ware_house_ID
		product_wg_ton,
		distributor_num,
		product_wg_ton/distributor_num as efficiency
	from fmcg
	order by efficiency desc
end;

exec WarehouseEffc

select * ,
case when efficiency = 1 then 'High'
     when efficiency = 2 then 'Medium'
	 else 'Low'
end as eff_category
from
(select
		Ware_house_ID
		product_wg_ton,
		distributor_num,
		ntile(3) over(order by product_wg_ton/distributor_num) as efficiency
from fmcg) as Efficiency_Table

--y) Create a View for Warehouse Overview:
--Question: How can you create a view that shows an overview of warehouses, including their location,
--product weight, and flood-proof status?
create view WarehousView as
select 
	Ware_house_ID,
	Location_type,
	product_wg_ton,
	flood_proof
from fmcg

select * from WarehousView;

--Insight: Above SQL show how to create a view (Temporary Table).View is declared using Table or 
--Tables SQL query.It will not store any records in it.

--z) Create a View for High-Capacity Warehouses. 
--Question: How would you create a view to display only those warehouses with a product 
--weight greater than 100 tons?
create view HighCapacity as 
select
	Ware_house_ID,
	product_wg_ton
from fmcg
where 
	product_wg_ton>100

select * from HighCapacity





