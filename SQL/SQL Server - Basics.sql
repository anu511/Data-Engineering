-- T-SQL or Transact SQL which is extension of SQl(Structured Query Language).
-- T-SQL developed by Microsoft for use of SQL Server,Azure SQL DB.
-- Key Features of T-SQL: a) Variable b)COntrol Flow Statements(IF-ELSE) c)Loops 
-- d)Try Catch e)Create Functions f)Stored Procedures 


--1.Show Databases
SELECT name FROM sys.databases;

--2.Show list of Schema
SELECT name as SchemaName from sys.schemas;

--3.Create new Database
CREATE database sales;

--4.Create a database with condition to test if it exists
--Declare a variable with name Databasename
DECLARE @Databasename VARCHAR(128) = 'sales';

--5.Test condition to check if database exists
IF NOT EXISTS(select 1 FROM sys.databases where name= @Databasename)
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename);
	EXEC sp_executesql @SQL;
END

--6.Change database
USE sales;

--7.Create table using schema name(dbo) which is default database
create table [dbo].products(productid varchar(20) not null,productname varchar(50),
price float,quantity int,storename varchar(50),city varchar(50))

--8.Insert values into Table products
INSERT INTO [dbo].products (productid, productname, price, quantity, storename, city) VALUES
('E001', 'Smartphone', 15000.00, 25, 'Tech World', 'Delhi'),
('E002', 'Laptop', 50000.00, 15, 'Gadget Hub', 'Mumbai'),
('E003', 'LED TV', 30000.00, 10, 'Electro Mart', 'Bangalore'),
('E004', 'Bluetooth Speaker', 2500.00, 40, 'Sound Zone', 'Chennai'),
('E005', 'Smartwatch', 8000.00, 20, 'Wearable Tech', 'Hyderabad'),
('E006', 'Wireless Earbuds', 3500.00, 30, 'Audio Bliss', 'Kolkata'),
('E007', 'External Hard Drive', 4500.00, 18, 'Storage Solutions', 'Pune'),
('E008', 'Digital Camera', 25000.00, 12, 'Photo Gear', 'Ahmedabad'),
('E009', 'Home Theater System', 22000.00, 8, 'Entertainment Central', 'Jaipur'),
('E010', 'Smart Refrigerator', 55000.00, 5, 'Home Appliances', 'Noida');

--9.Run query on products table to show all records
select * from products;

--10.Show the schema description 
SELECT 
	TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME,DATA_TYPE,IS_NULLABLE
FROM 
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'products';

--11.Drop Table
--DROP TABLE products;

--12.Alter Table
ALTER TABLE products ADD totalamount float;
alter table products add transactiondate date;

--13.Drop Columns using Alter
ALTER TABLE products DROP column transactiondate;

--14.Update Column Datatype
alter table products alter column totalamount decimal(18,2);

--15.Update the Value of Column totalamount = price*quantity
update products set totalamount = price * quantity;

select * from products

--16.Query to show first 5 records
SELECT TOP (5) [productid]
      ,[productname]
      ,[price]
      ,[quantity]
      ,[storename]
      ,[city]
      ,[totalamount]
  FROM [sales].[dbo].[products]
