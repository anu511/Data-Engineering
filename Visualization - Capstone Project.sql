-- Databricks notebook source
-- MAGIC %python
-- MAGIC
-- MAGIC account_name = "capstonestorage001"
-- MAGIC account_key = "BY59d83vF22ri+DpwUKIc4Tgbv5oukkSw+KL/YnW8I7w2d1+xqXp/LTInlMLht8KeGFHKrj/j4/o+AStb5Bs0A=="
-- MAGIC container_name = "datacotransformed"
-- MAGIC
-- MAGIC # Set the Azure Blob Storage account access key in the Spark configuration
-- MAGIC spark.conf.set(f"fs.azure.account.key.{account_name}.blob.core.windows.net", account_key)
-- MAGIC
-- MAGIC # Define the path to the Parquet file
-- MAGIC parquet_file_path = f"wasbs://{container_name}@{account_name}.blob.core.windows.net/transformed_data/"
-- MAGIC
-- MAGIC # Read the Parquet file into a DataFrame
-- MAGIC dataco_df = spark.read.parquet(parquet_file_path)
-- MAGIC
-- MAGIC # Show the first few rows of the DataFrame
-- MAGIC dataco_df.show()
-- MAGIC

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC account_name = "capstonestorage001"
-- MAGIC account_key = "BY59d83vF22ri+DpwUKIc4Tgbv5oukkSw+KL/YnW8I7w2d1+xqXp/LTInlMLht8KeGFHKrj/j4/o+AStb5Bs0A=="
-- MAGIC container_name = "transformation"
-- MAGIC spark.conf.set(f"fs.azure.account.key.{account_name}.blob.core.windows.net", account_key)
-- MAGIC
-- MAGIC
-- MAGIC parquet_file_path = f"wasbs://{container_name}@{account_name}.blob.core.windows.net/transformed_data/"
-- MAGIC
-- MAGIC logdata = spark.read.parquet(parquet_file_path)
-- MAGIC
-- MAGIC
-- MAGIC logdata.show()

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Create Materialized View

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dataco_df.createOrReplaceTempView('dataco')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Shape of the data

-- COMMAND ----------

SELECT count(*) as TotalRecords FROM dataco 

-- COMMAND ----------

-- MAGIC %python
-- MAGIC len(dataco_df.columns)

-- COMMAND ----------

SELECT round(sum(Sales_Per_Customer),2) as TotalSales FROM dataco

-- COMMAND ----------

SELECT count(distinct Product_Name) as Total_Products from dataco

-- COMMAND ----------

SELECT AVG(Benefit_Per_Order) AS avg_benefit
FROM dataco


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Top 10 Product Categories

-- COMMAND ----------

SELECT
    Category_Name,
    ROUND(SUM(Order_Item_Profit_Ratio * Order_Item_Quantity),3) AS Total_Profit,
    DENSE_RANK() OVER (ORDER BY SUM(Order_Item_Profit_Ratio * Order_Item_Quantity) DESC) AS Rank
FROM 
    dataco
GROUP BY 
    Category_Name
ORDER BY 
    Rank
LIMIT 10


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Top 10 Order Regions

-- COMMAND ----------

SELECT 
    Order_Region, 
    ROUND(SUM(Sales),2) AS Total_Sales
FROM 
    dataco
GROUP BY 
    Order_Region
ORDER BY 
    Total_Sales DESC
LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Type of Payment Methods Used

-- COMMAND ----------

SELECT 
    Type, 
    COUNT(*) AS Order_Count
FROM 
    dataco
GROUP BY 
    Type
ORDER BY 
    Order_Count DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Types of Shipping Methods Used

-- COMMAND ----------

SELECT 
    Shipping_Mode, 
    COUNT(*) AS Count
FROM 
    dataco
GROUP BY 
    Shipping_Mode
ORDER BY 
    Count DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Late Delivery Risk analysis

-- COMMAND ----------

SELECT Late_delivery_risk, COUNT(*) AS Risk_count
FROM dataco
GROUP BY Late_delivery_risk
ORDER BY Risk_count DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Order Fulfillment Efficiency

-- COMMAND ----------

SELECT 
    Category_Name, 
    ROUND(AVG(Days_For_Shipment_Scheduled),3) AS avg_scheduled_days, 
    ROUND(AVG(Days_For_Shipping_Real),3) AS avg_real_days,
    ROUND(AVG(Days_For_Shipping_Real - Days_For_Shipment_Scheduled),3) AS avg_delay
FROM dataco
GROUP BY Category_Name
ORDER BY avg_delay DESC
LIMIT 10;


-- COMMAND ----------

-- MAGIC %python
-- MAGIC dataco_df.columns

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Revenue Contribution by Product and Region (NR)

-- COMMAND ----------

SELECT 
    Product_Name, 
    Customer_City, 
    SUM(Sales_per_customer) AS total_sales
FROM dataco
GROUP BY Product_Name,Customer_City
ORDER BY total_sales DESC
LIMIT 10


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Profitability Analysis by Category and Shipping Mode

-- COMMAND ----------

SELECT 
    Category_Name, 
    Shipping_Mode, 
    SUM(Benefit_per_order) AS total_benefit, 
    SUM(Sales_per_customer) AS total_sales,
    (SUM(Benefit_per_order) / SUM(Sales_per_customer)) * 100 AS Profit_percentage
FROM dataco
GROUP BY Category_Name, Shipping_Mode
ORDER BY total_benefit DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Year over Year Trend Analysis

-- COMMAND ----------

SELECT 
    YEAR(Shipping_Date_Dateorders) AS order_year, 
    MONTH(Shipping_Date_Dateorders) AS order_month,
    SUM(Sales_per_customer) AS total_sales
FROM dataco
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Top Products with High Late Delivery Risk
-- MAGIC Insight: Identify which products are most at risk of late delivery

-- COMMAND ----------

SELECT 
    Product_Name, 
    Category_Name,
    COUNT(*) AS Late_deliveries
FROM dataco
WHERE Late_delivery_risk = 1
GROUP BY Product_Name,Category_Name
ORDER BY late_deliveries DESC
LIMIT 10;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Geographical details of the Top Customer Cities of Order
-- MAGIC

-- COMMAND ----------

SELECT 
    Customer_City,
    Latitude,
    Longitude,
    total_sales,
    total_orders
FROM (
    SELECT 
        Customer_City,
        Latitude,
        Longitude,
        SUM(Sales_per_customer) AS total_sales,
        COUNT(Order_Id) AS total_orders,
        ROW_NUMBER() OVER (PARTITION BY Customer_City ORDER BY SUM(Sales_per_customer) DESC) AS country_rank
    FROM 
        dataco
    GROUP BY 
        Customer_City, Latitude, Longitude
) AS ranked_sales
WHERE 
    country_rank = 1
ORDER BY 
    total_sales DESC
LIMIT 15;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Trends of Sales Growth by Month

-- COMMAND ----------

SELECT
    EXTRACT(YEAR FROM Order_Date_Dateorders) as sales_year,
    EXTRACT(MONTH FROM Order_Date_Dateorders) AS sales_month,
    SUM(Sales) AS total_sales,
    LAG(SUM(Sales)) OVER (ORDER BY EXTRACT(YEAR FROM Order_Date_Dateorders),EXTRACT(MONTH FROM Order_Date_Dateorders)) AS prev_month_sales,
    (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY EXTRACT(YEAR FROM Order_Date_Dateorders),EXTRACT(MONTH FROM Order_Date_Dateorders))) / NULLIF(LAG(SUM(Sales)) OVER (ORDER BY EXTRACT(YEAR FROM Order_Date_Dateorders),EXTRACT(MONTH FROM Order_Date_Dateorders)), 0) * 100 AS sales_growth
FROM 
    dataco
GROUP BY 
    EXTRACT(YEAR FROM Order_Date_Dateorders),
    EXTRACT(MONTH FROM Order_Date_Dateorders)
ORDER BY
    sales_year,
    sales_month;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Rank Customer Segments

-- COMMAND ----------

SELECT
    Customer_Segment,
    RANK() OVER (ORDER BY total_sales DESC) AS segment_rank
FROM (
    SELECT 
        Customer_Segment,
        ROUND(SUM(Sales),3) AS total_sales,
        COUNT(DISTINCT Order_Id) AS total_orders,
        ROUND(AVG(Sales),3) AS avg_order_value
    FROM 
        dataco
    GROUP BY 
        Customer_Segment
) AS CustomerSales
ORDER BY 
    Segment_rank;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Log Data

-- COMMAND ----------

-- MAGIC %python
-- MAGIC logdata.createOrReplaceTempView('logdata')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Traffic analysis

-- COMMAND ----------

SELECT COUNT(*) AS total_clicks
FROM logdata;

-- COMMAND ----------

-- Monthly traffic analysis
SELECT Month, COUNT(*) AS clicks
FROM logdata
GROUP BY Month
ORDER BY clicks desc;


-- COMMAND ----------

-- Hourly traffic analysis
SELECT Hour, COUNT(*) AS clicks
FROM logdata
GROUP BY Hour
ORDER BY clicks desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Peak Traffic Hours
-- MAGIC * The monthly analysis shows that September has the highest traffic
-- MAGIC * The hourly analysis shows the highest traffic during night.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### User Behavior

-- COMMAND ----------

SELECT ip, COUNT(*) AS visits
FROM logdata
GROUP BY ip
HAVING COUNT(*) > 1
ORDER BY visits DESC
LIMIT 20;

-- COMMAND ----------

-- Common navigation paths (requires more detailed path tracking data, simplified example)
SELECT 
    previous_url,
    current_url,
    COUNT(*) AS transitions
FROM (
    SELECT 
        LAG(url) OVER (PARTITION BY ip ORDER BY Date, Hour) AS Previous_Url,
        url AS Current_Url
    FROM logdata
) AS path_transitions
WHERE previous_url IS NOT NULL
GROUP BY previous_url, current_url
ORDER BY transitions DESC
LIMIT 10;



-- COMMAND ----------

-- MAGIC %md
-- MAGIC * Several transitions are from a URL to itself, indicating users refreshing the same product page frequently.
-- MAGIC * Users are frequently moving from product pages to adding items to their cart and then back to the product pages
