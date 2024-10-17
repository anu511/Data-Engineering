DECLARE @Databasename VARCHAR(128) = 'GreenTaxiDB';
IF NOT EXISTS(select 1 FROM sys.databases where name= @Databasename)
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename);
	EXEC sp_executesql @SQL;
END

USE GreenTaxiDB;

CREATE TABLE TaxiTrips (
    VendorID INT,  
    lpep_pickup_datetime DATETIME, 
    lpep_dropoff_datetime DATETIME, 
    store_and_fwd_flag CHAR(5),  
    RatecodeID INT,  
    PULocationID INT,  
    DOLocationID INT,  
    passenger_count INT, 
    trip_distance FLOAT,  
    fare_amount FLOAT,  
    extra FLOAT,  
    mta_tax FLOAT,  
    tip_amount FLOAT,  
    tolls_amount FLOAT,  
    ehail_fee FLOAT,  
    improvement_surcharge FLOAT,  
    total_amount FLOAT, 
    payment_type INT,  
    trip_type INT,  
    congestion_surcharge FLOAT 
);

BULK INSERT TaxiTrips FROM 'D:/2021_Green_Taxi_Trip_Data.csv'
WITH 
(
	FIELDTERMINATOR = ',',  --'|',';','\t',' '
	ROWTERMINATOR = '0x0a',  --Carriage & New Line Character - '\r\n','\n','0x0a'-line feed
	FIRSTROW = 2		--skip the header from the records
);

select * from TaxiTrips;


--1)Shape of the Table (Number of Rows and Columns)
select count(*) as NoOfRows from TaxiTrips;
select count(*) as NoOfColumsn from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'TaxiTrips';

--2)Show Summary of Green Taxi Rides – Total Rides, Total Customers, Total Sales,
select
	count(*) as total_rides,
	sum(passenger_count) as total_customers,
	sum(total_amount) as total_sales
from TaxiTrips

--3)Total Rides with Surcharge and its percentage. 
select 
	VendorID, 
	trip_distance, 
	(improvement_surcharge + congestion_surcharge) as total_surcharge,
	ROUND((improvement_surcharge + congestion_surcharge) / total_amount * 100,2) as surcharge_percentage
from TaxiTrips
where total_amount > 0 and improvement_surcharge > 0

--4)Cumulative Sum of Total Fare Amount for Each Pickup Location
select
	PULocationID,fare_amount,
	sum(fare_amount) over(partition by PULocationID order by fare_amount asc
	rows between unbounded preceding and current row)
	as Cumulative_Sum
from TaxiTrips

--5) Which Payment Type is Most Common in Each Drop-off Location
select DOLocationID,max(payment_count) as Common_payment_type from
(select 
	DOLocationID,
	payment_type, 
	count(payment_type) as payment_count
from TaxiTrips
where payment_type is not null
group by DOLocationID,payment_type
)as _
group by DOLocationID
order by DOLocationID

--6) Create a New Column for Trip Distance Band and Show Distribution
ALTER TABLE TaxiTrips ADD Trip_Distance_Band VARCHAR(30)

UPDATE TaxiTrips
set Trip_Distance_Band =
case
	when TILE = 1 then 'Long Distance'
	when TILE = 2 then 'Medium Distance'
	else 'Short Distance'
end
from (
	select trip_distance,
	NTILE(3) over(order by trip_distance DESC) as TILE
	from TaxiTrips
) AS _

--7) Find the Most Frequent Pickup Location (Mode) with rides fare greater than average of ride fare
select
	PULocationID,
	count(PULocationID) as pickup_count
from TaxiTrips
where fare_amount>(select avg(fare_amount) from TaxiTrips)
group by PULocationID
order by pickup_count desc

select * from TaxiTrips

--8) Show the Rate Code with the Highest Percentage of Usage
select
	RatecodeID,
	count(RatecodeID) as rate_code_count
from TaxiTrips
group by RatecodeID
order by COUNT(RatecodeID) desc

--9)Show Distribution of Tips, Find the Maximum Chances of Getting a Tip
select 
	trip_type,
	count(tip_amount) as total_tip
from TaxiTrips
group by trip_type
order by total_tip desc

--10)Calculate the Rank of Trips Based on Fare Amount within Each Pickup Location
select
	PULocationID,
	fare_amount,
	rank() over(partition by PULocationID order by fare_amount)as rank
from TaxiTrips

--11)Find Top 20 Most Frequent Rides Routes.



--12)Calculate the Average Fare of Completed Trips vs. Cancelled Trips
select AVG(fare_amount) as avg_fare_completed_trips
from TaxiTrips
where trip_distance>0 

select AVG(fare_amount) as avg_fare_cancelled_trips
from TaxiTrips
where trip_distance=0

--13)Rank the Pickup Locations by Average Trip Distance and Average Total Amount.
select 
	PULocationID,
	avg(trip_distance) as avg_trip_distance,
	avg(total_amount) as avg_total_amount,
	rank() over(order by avg(trip_distance) desc,avg(total_amount) desc) as pu_rank
from TaxiTrips
group by PULocationID


--14)Find the Relationship Between Trip Distance & Fare Amount
select 
	trip_distance,avg(fare_amount)as avg_fare
from TaxiTrips
group by trip_distance
order by trip_distance asc

--15)Identify Trips with Outlier Fare Amounts within Each Pickup Location
select 
	PULocationID, 
	max(total_amount) as total_amount
from TaxiTrips 
group by PULocationID 
order by total_amount desc;

select PULocationID, fare_amount from
(select PULocationID, fare_amount,
	PERCENTILE_CONT(0.25)  WITHIN GROUP (ORDER BY fare_amount) OVER() as Q1,
	PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY fare_amount) OVER() as Q2,
	PERCENTILE_CONT(0.75)  WITHIN GROUP (ORDER BY fare_amount) OVER() as Q3,
	PERCENTILE_CONT(0.75)  WITHIN GROUP (ORDER BY fare_amount) OVER() -
	PERCENTILE_CONT(0.25)  WITHIN GROUP (ORDER BY fare_amount) OVER() as IQR
from taxitrips) Quartiles
where fare_amount < Q1 - 1.5*IQR or fare_amount > Q3 + 1.5*IQR
order by fare_amount

--16)Categorize Trips Based on Distance Travelled
select 
	trip_distance ,
	tile,
case
	when tile>=3 then 'large'
	when tile>=2 then 'medium'
	else 'low'
end as category
from(
	select trip_distance ,ntile(3) over (order by trip_distance) as tile from TaxiTrips)
as TileCTE;


--17)Top 5 Busiest Pickup Locations, Drop Locations with Fare less than median total fare
with medianfare as 
	(select PERCENTILE_CONT(0.5) within group (order by total_amount) over() 
	as MedianPrice
	from taxitrips)
select top(5) 
	PULocationID, 
	DOLocationID, 
	total_amount 
from TaxiTrips 
where total_amount<(select max(MedianPrice) from medianfare) and total_amount>0 
order by total_amount desc;

--18)Distribution of Payment Types
select 
	payment_type, 
	count(*) as count_type 
from taxitrips 
group by(payment_type)
order by payment_type;

--19)Trips with Congestion Surcharge Applied and Its Percentage Count.
select 
	PULocationID, 
	congestion_surcharge,
case
	when total_amount>0 then (congestion_surcharge * 100.0 / total_amount)
	else 0
end as percentag
from TaxiTrips 
where congestion_surcharge>0;

--20)Top 10 Longest Trip by Distance and Its summary about total amount.
select top(10) 
	trip_distance,
	total_amount 
from TaxiTrips 
order by trip_distance desc;

--21)Trips with a Tip Greater than 20% of the Fare
select 
	PULocationID, 
	tip_amount,
	((tip_amount * 100.0 / total_amount)) as perc
from TaxiTrips 
where total_amount>0 and tip_amount>0 and (tip_amount * 100.0 / total_amount)>20
order by PULocationID;

--22)Average Trip Duration by Rate Code
select 
	RatecodeID, 
	avg(datediff(MINUTE,lpep_pickup_datetime,lpep_dropoff_datetime))as avg_diff 
from taxitrips 
group by RatecodeID 
order by RatecodeID;


--23)Total Trips per Hour of the Day
select 
	DATEPART(HOUR,lpep_pickup_datetime ) as newtime,
	count(DATEPART(HOUR,lpep_pickup_datetime )) as counts 
from taxitrips 
group by DATEPART(HOUR,lpep_pickup_datetime ) 
order by counts desc;


--24)Show the Distribution about Busiest Time in a Day.
select 
	convert(VARCHAR(8),lpep_pickup_datetime,108) as newtime,
	count( CONVERT(VARCHAR(8),lpep_pickup_datetime,108)) as counts 
from taxitrips 
group by lpep_pickup_datetime 
order by counts desc;

