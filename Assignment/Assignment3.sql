DECLARE @Databasename VARCHAR(128) = 'HREmployeeDB';
IF NOT EXISTS(select 1 FROM sys.databases where name= @Databasename)
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename);
	EXEC sp_executesql @SQL;
END

USE HREmployeeDB;

CREATE TABLE emp(
    Attrition VARCHAR(10),
    Business_Travel VARCHAR(20),
    CF_age_band VARCHAR(10),
    CF_attrition_label VARCHAR(20),
    Department VARCHAR(50),
    Education_Field VARCHAR(50),
    emp_no VARCHAR(10),
    Employee_Number INT,
    Gender VARCHAR(10),
    Job_Role VARCHAR(50),
    Marital_Status VARCHAR(10),
    Over_Time VARCHAR(10),
    Over18 VARCHAR(10),
    Training_Times_Last_Year INT,
    Age INT,
    CF_current_Employee VARCHAR(10),
    Daily_Rate INT,
    Distance_From_Home INT,
    Education VARCHAR(20),
    Employee_Count INT,
    Environment_Satisfaction INT,
    Hourly_Rate INT,
    Job_Involvement INT,
    Job_Level INT,
    Job_Satisfaction INT,
    Monthly_Income INT,
    Monthly_Rate INT,
    Num_Companies_Worked INT,
    Percent_Salary_Hike INT,
    Performance_Rating INT,
    Relationship_Satisfaction INT,
    Standard_Hours INT,
    Stock_Option_Level INT,
    Total_Working_Years INT,
    Work_Life_Balance INT,
    Years_At_Company INT,
    Years_In_Current_Role INT,
    Years_Since_Last_Promotion INT,
    Years_With_Curr_Manager INT
);

BULK INSERT emp FROM 'D:/HR_Employee_Data.csv'
WITH 
(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2		--skip the header from the records
);

--a) Return the shape of the table
select count(*) as Row_Count from emp;
select count(*) as Column_Count from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'emp';

--b) Calculate the cumulative sum of total working years for each department
select
	Department,
	sum(Total_Working_Years) 
	over(partition by Department order by Total_Working_Years rows between unbounded preceding and current row)
	as cumulative_sum
from emp;

--c) Which gender have higher strength as workforce in each department

select  Department, Gender, Gender_Count From(
select
	Department, Gender, count(*) as Gender_Count,
	rank() over(partition by Department 
				order by count(*) desc) as Gender_rank
	from emp
	group by Department, Gender) as gen
where Gender_rank = 1
order by Gender_Count

--d) Create a new column AGE_BAND and Show Distribution of Employee's Age band group
--(Below 25, 25-34, 35-44, 45-55. ABOVE 55)
alter table emp add age_band varchar(20)

update emp
set age_band = case
		when CF_age_band = 'Under 25' then 1
        when CF_age_band = '25 - 34' then 2
        when CF_age_band = '35 - 44' then 3
        when CF_age_band = '45 - 54' then 4
        when CF_age_band = 'Over 55' then 5
        else 6
    end;

select age_band,CF_age_band
from emp



select
    CF_age_band ,count(*) AS EmployeeCount
from emp
group by CF_age_band
order by
    case
        when CF_age_band = 'Under 25' then 1
        when CF_age_band = '25 - 34' then 2
        when CF_age_band = '35 - 44' then 3
        when CF_age_band = '45 - 54' then 4
        when CF_age_band = 'Over 55' then 5
        else 6
    end;




--e) Compare all marital status of employee and find the most frequent marital status
select top(1)
	Marital_Status,
	count(*) as count_of_marital_status
from emp
group by Marital_Status
order by count_of_marital_status desc;

--f) Show the Job Role with Highest Attrition Rate (Percentage)
--select Job_Role,Attrition,count(Attrition) from emp group by Job_Role,Attrition order by Job_Role
select top(1) 
	Job_Role,
	yes_count*100.0/total_count as attrition_perc
from (select Job_Role,
	  count(case when Attrition ='Yes' then 1 end) as yes_count,
	  count(*) as total_count
	  from emp
	  group by Job_Role
	  )_
order by attrition_perc desc

--g) Show distribution of Employee's Promotion, Find the maximum chances of employee
--getting promoted.
select
	Years_Since_Last_Promotion,
	count(*) as Num_of_emp
from emp
group by Years_Since_Last_Promotion
order by Years_Since_Last_Promotion

select Job_Role,Performance_Rating,Years_In_Current_Role,Years_At_Company,Years_Since_Last_Promotion,
	Job_Involvement,Training_Times_Last_Year
from emp
group by Attrition,Job_Role,Performance_Rating,Years_In_Current_Role,Years_At_Company,Years_Since_Last_Promotion,
	Job_Involvement,Training_Times_Last_Year
order by Years_At_Company

--h) Show the cumulative sum of total working years for each department.
select
	Department,
	sum(Total_Working_Years) 
	over(partition by Department order by Department rows between unbounded preceding and current row)
	as cumulative_sum
from emp;

--i) Find the rank of employees within each department based on their monthly income
select
	Employee_Number,
	Department,
	Monthly_Income,
	rank() over(partition by Department order by Monthly_Income) as Rank
from emp;

--j) Calculate the running total of 'Total Working Years' for each employee within each
--department and age band.
select 
	Department,
	CF_age_band,
	Total_Working_Years,
	sum(Total_Working_Years) 
	over(partition by Department,CF_age_band order by Department rows between unbounded preceding and current row)
	as running_total
from emp

--k)For each employee who left, calculate the number of years they worked before leaving and
--compare it with the average years worked by employees in the same department.
select
	emp_no,
	dept.Department,
	Years_At_Company,
	avg_year 
from emp left join(
			select Department,avg(Years_At_Company) as avg_year
			from emp
			group by Department
		)as dept
on dept.Department = emp.Department

--l)Rank the departments by the average monthly income of employees who have left.
select
	Department,
	avg_mon_income,
	rank() over(order by avg_mon_income desc) as Rank
from(
	select Department,avg(Monthly_Income) as avg_mon_income
	from emp
	where Attrition='Yes'
	group by Department
	) as AvgMonInc

--m) Find the if there is any relation between Attrition Rate and Marital Status of Employee.
select
	Attrition,
	Marital_Status,
	count(*) as marital_count
from emp
group by Marital_Status,Attrition
order by Marital_Status

--n) Show the Department with Highest Attrition Rate (Percentage)
select 
	Department,
	(count(case when Attrition = 'Yes' then 1 end)*100)/count(*) as yes_percent
from emp
group by Department

-- o) Calculate the moving average of monthly income over the past 3 employees for each job role.
select
	emp_no,
	Monthly_Income,
	avg(Monthly_Income) over(order by Monthly_Income rows between 2 preceding  and current row)
	as moving_Avg
from emp

-- p) Identify employees with outliers in monthly income within each job role. [ Condition : 
--Monthly_Income < Q1 - (Q3 - Q1) * 1.5 OR Monthly_Income > Q3 + (Q3 - Q1) ]
select Job_Role,Monthly_Income
from(select Job_Role,Monthly_Income,
	 PERCENTILE_CONT(0.25) within group(order by Monthly_Income)over() as q1,
	 PERCENTILE_CONT(0.5) within group(order by Monthly_Income)over() as q2,
	 PERCENTILE_CONT(0.75) within group(order by Monthly_Income)over() as q3
	 from emp
) as outliers
where Monthly_Income<q1-(q3-q1)*1.5 or Monthly_Income>(q3+(q3-q1))

-- q) Gender distribution within each job role, show each job role with its gender domination. 
--[Male_Domination or Female_Domination]
select 
	Job_Role,
	Gender,
	rank() over(partition by Job_Role order by count(*) desc) as Rank
from emp
group by Job_Role,Gender

--r) Percent rank of employees based on training times last year
select
	emp_no,
	Training_Times_Last_Year,
	PERCENT_RANK() over(order by Training_Times_Last_Year) as training_perc
from emp

--s) Divide employees into 5 groups based on training times last year [Use NTILE ()]
select
	emp_no,
	Training_Times_Last_Year,
	ntile(5) over(order by Training_Times_Last_Year) as groups
from emp

--t) Categorize employees based on training times last year as - Frequent Trainee, Moderate 
--Trainee, Infrequent Trainee
select
	emp_no,
	Training_Times_Last_Year,
	case
		when Training_Times_Last_Year>4 then 'Frequent Trainee'
		when Training_Times_Last_Year>2 then 'Moderate Trainee'
		else 'Infrequent Trainee'
	end as 'Training_Frequency'
from emp
order by Training_Times_Last_Year desc


--u) Categorize employees as 'High', 'Medium', or 'Low' performers based on their performance 
--rating, using a CASE WHEN statement.
select
	emp_no,
	Performance_Rating,
	case
		when Performance_Rating>3 then 'High'
		when Training_Times_Last_Year>1 then 'Medium'
		else 'Low'
	end as 'PerformanceRating'
from emp
order by Performance_Rating desc

--v) Use a CASE WHEN statement to categorize employees into 'Poor', 'Fair', 'Good', or 'Excellent' 
--work-life balance based on their work-life balance score.
select
	emp_no,
	Work_Life_Balance,
	case
		when Work_Life_Balance>3 then 'Excellent'
		when Work_Life_Balance>1 then 'Fair'
		else 'Poor'
	end as 'Rating'
from emp
order by Work_Life_Balance desc

--w) Group employees into 3 groups based on their stock option level using the [NTILE] function.
select
	emp_no,
	Stock_Option_Level,
	NTILE(3) over(order by Stock_Option_Level) as Groups
from emp

--x)Find key reasons for Attrition in Company
select
	avg(Age) as avg_age,
	avg(Monthly_Income) as avg_income,
	avg(Distance_From_Home) as avg_dist,
	avg(Job_Satisfaction) as avg_satisfaction,
	avg(Work_Life_Balance) as avg_work_life_bal,
	Department,
	Job_Role
from emp
where Attrition = 'Yes'
group by Department,Job_Role
order by Department,avg_income