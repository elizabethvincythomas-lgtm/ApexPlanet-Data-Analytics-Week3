/*
  Week 3 - Deep-Dive Analysis: Customer Segmentation
  Prepared by: Elizabeth Vincy Thomas

  Prerequisite: import data/processed/cleaned_sales_dataset_sql.csv into
  ApexPlanetWeek1 as dbo.clean_sales (same table used in Week 2).
*/

USE ApexPlanetWeek1;
GO

/* KPI definitions for the interactive dashboard */
SELECT
    CAST(SUM(Total_Sales) AS DECIMAL(18,2)) AS Total_Revenue,
    COUNT(*) AS Transactions,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    CAST(AVG(Total_Sales) AS DECIMAL(18,2)) AS Average_Order_Value,
    SUM(Quantity) AS Units_Sold
FROM dbo.clean_sales;
GO

/* Create a reusable customer-level segmentation view.
   Rules are based on total customer revenue:
   Low Value: below 100,000
   Medium Value: 100,000 to below 250,000
   High Value: 250,000 and above */
CREATE OR ALTER VIEW dbo.vw_customer_segments
AS
WITH customer_base AS (
    SELECT
        Customer_ID,
        MAX(Customer_Name) AS Customer_Name,
        MAX(City) AS City,
        MAX(Gender) AS Gender,
        MAX(Age_Group) AS Age_Group,
        COUNT(DISTINCT Order_ID) AS Orders,
        SUM(Quantity) AS Units_Sold,
        CAST(SUM(Total_Sales) AS DECIMAL(18,2)) AS Customer_Revenue,
        CAST(AVG(Total_Sales) AS DECIMAL(18,2)) AS Average_Order_Value,
        MIN(Order_Date) AS First_Order_Date,
        MAX(Order_Date) AS Last_Order_Date
    FROM dbo.clean_sales
    GROUP BY Customer_ID
)
SELECT *,
    CASE
        WHEN Customer_Revenue >= 250000 THEN 'High Value'
        WHEN Customer_Revenue >= 100000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Segment
FROM customer_base;
GO

/* Deep-dive 1: segment size, contribution, and customer value */
SELECT
    Customer_Segment,
    COUNT(*) AS Customers,
    SUM(Orders) AS Orders,
    CAST(SUM(Customer_Revenue) AS DECIMAL(18,2)) AS Segment_Revenue,
    CAST(100.0 * SUM(Customer_Revenue) / SUM(SUM(Customer_Revenue)) OVER () AS DECIMAL(5,2)) AS Revenue_Share_Percent,
    CAST(AVG(Customer_Revenue) AS DECIMAL(18,2)) AS Average_Customer_Value,
    CAST(AVG(Average_Order_Value) AS DECIMAL(18,2)) AS Average_Order_Value
FROM dbo.vw_customer_segments
GROUP BY Customer_Segment
ORDER BY Segment_Revenue DESC;
GO

/* Deep-dive 2: city and segment combination */
SELECT
    City,
    Customer_Segment,
    COUNT(*) AS Customers,
    CAST(SUM(Customer_Revenue) AS DECIMAL(18,2)) AS Revenue,
    CAST(AVG(Customer_Revenue) AS DECIMAL(18,2)) AS Average_Customer_Value
FROM dbo.vw_customer_segments
GROUP BY City, Customer_Segment
ORDER BY City, Revenue DESC;
GO

/* Deep-dive 3: age-group and segment combination */
SELECT
    Age_Group,
    Customer_Segment,
    COUNT(*) AS Customers,
    CAST(SUM(Customer_Revenue) AS DECIMAL(18,2)) AS Revenue
FROM dbo.vw_customer_segments
GROUP BY Age_Group, Customer_Segment
ORDER BY Age_Group, Revenue DESC;
GO

/* Deep-dive 4: top high-value customers */
SELECT TOP (10)
    Customer_ID,
    Customer_Name,
    City,
    Age_Group,
    Orders,
    Units_Sold,
    Customer_Revenue,
    Average_Order_Value
FROM dbo.vw_customer_segments
WHERE Customer_Segment = 'High Value'
ORDER BY Customer_Revenue DESC;
GO

/* Power BI friendly transaction extract with the customer segment attached */
SELECT
    s.Order_ID, s.Order_Date, s.Customer_ID, s.Customer_Name, s.Age,
    s.Gender, s.City, s.Product, s.Category, s.Quantity, s.Unit_Price,
    s.Total_Sales, s.Order_Year, s.Order_Month, s.Order_Month_Name,
    s.Age_Group, c.Customer_Segment
FROM dbo.clean_sales AS s
INNER JOIN dbo.vw_customer_segments AS c
    ON s.Customer_ID = c.Customer_ID;
GO
