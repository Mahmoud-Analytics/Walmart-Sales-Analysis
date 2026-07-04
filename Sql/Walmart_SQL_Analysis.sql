CREATE DATABASE Walmart_Sales_Analysis;

USE Walmart_Sales_Analysis;

select top 10 * from Walmart_Sales

Select Count(*) As total_rows
From Walmart_Sales

SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'walmart_sales';

SELECT
    COUNT(DISTINCT Store) AS total_stores,
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM walmart_sales;

SELECT
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales,
    MAX(Weekly_Sales) AS max_weekly_sales,
    MIN(Weekly_Sales) AS min_weekly_sales
FROM walmart_sales;

SELECT top 10 
       Store,
       SUM(Weekly_Sales) As total_sales
FROM walmart_sales
Group by Store
Order by total_sales Desc;

SELECT
    Holiday_Status,
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales
FROM walmart_sales
GROUP BY Holiday_Status
ORDER BY total_sales DESC;

SELECT
    Year,
    SUM(Weekly_Sales) AS total_sales
FROM walmart_sales
GROUP BY Year
ORDER BY Year;

SELECT
    Month,
    Month_Name,
    SUM(Weekly_Sales) AS total_sales
FROM walmart_sales
GROUP BY Month, Month_Name
ORDER BY Month;

SELECT
    Year,
    Month,
    Month_Name,
    SUM(Weekly_Sales) AS total_sales
FROM walmart_sales
GROUP BY Year, Month, Month_Name
ORDER BY Year, Month;

SELECT TOP 10 
      Store,
      sum(Weekly_sales) As total_sales
FROM Walmart_Sales
Group by Store
Order by total_sales Asc;

SELECT 
      Store,
      AVG(Weekly_Sales) As avg_total_sales
FROM Walmart_Sales
Group by Store
Order by avg_total_sales Desc;

SELECT TOP 10
    Store,
    Date,
    Weekly_Sales,
    Holiday_Status
FROM walmart_sales
ORDER BY Weekly_Sales DESC;

SELECT
    Year,
    Holiday_Status,
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales
FROM walmart_sales
GROUP BY Year, Holiday_Status
ORDER BY Year, Holiday_Status;


/*  Top Store in Each Year */
WITH store_sales AS (
    SELECT
        [Year],
        Store,
        SUM(Weekly_Sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY [Year]
            ORDER BY SUM(Weekly_Sales) DESC
        ) AS rn
    FROM walmart_sales
    GROUP BY [Year], Store
)
SELECT
    [Year],
    Store,
    total_sales
FROM store_sales
WHERE rn = 1
ORDER BY [Year];


/*  Best Month in Each Year */
WITH monthly_sales AS (
    SELECT
        [Year],
        [Month],
        Month_Name,
        SUM(Weekly_Sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY [Year]
            ORDER BY SUM(Weekly_Sales) DESC
        ) AS rn
    FROM walmart_sales
    GROUP BY [Year], [Month], Month_Name
)
SELECT
    [Year],
    [Month],
    Month_Name,
    total_sales
FROM monthly_sales
WHERE rn = 1
ORDER BY [Year];


/*  Sales and Average Temperature by Year */
SELECT
    [Year],
    SUM(Weekly_Sales) AS total_sales,
    AVG(Temperature) AS avg_temperature
FROM walmart_sales
GROUP BY [Year]
ORDER BY [Year];


/*  Sales and Average Fuel Price by Year */
SELECT
    [Year],
    SUM(Weekly_Sales) AS total_sales,
    AVG(Fuel_Price) AS avg_fuel_price
FROM walmart_sales
GROUP BY [Year]
ORDER BY [Year];


/*  Sales and Average CPI by Year */
SELECT
    [Year],
    SUM(Weekly_Sales) AS total_sales,
    AVG(CPI) AS avg_cpi
FROM walmart_sales
GROUP BY [Year]
ORDER BY [Year];


/*  Sales and Average Unemployment by Year */
SELECT
    [Year],
    SUM(Weekly_Sales) AS total_sales,
    AVG(Unemployment) AS avg_unemployment
FROM walmart_sales
GROUP BY [Year]
ORDER BY [Year];


/*  Sales by Temperature Level */
SELECT
    CASE
        WHEN Temperature < 40 THEN 'Cold'
        WHEN Temperature BETWEEN 40 AND 70 THEN 'Moderate'
        ELSE 'Hot'
    END AS temperature_level,
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales
FROM walmart_sales
GROUP BY
    CASE
        WHEN Temperature < 40 THEN 'Cold'
        WHEN Temperature BETWEEN 40 AND 70 THEN 'Moderate'
        ELSE 'Hot'
    END
ORDER BY total_sales DESC;


/*  Sales by Fuel Price Level */
SELECT
    CASE
        WHEN Fuel_Price < 3 THEN 'Low Fuel Price'
        WHEN Fuel_Price BETWEEN 3 AND 4 THEN 'Medium Fuel Price'
        ELSE 'High Fuel Price'
    END AS fuel_price_level,
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales
FROM walmart_sales
GROUP BY
    CASE
        WHEN Fuel_Price < 3 THEN 'Low Fuel Price'
        WHEN Fuel_Price BETWEEN 3 AND 4 THEN 'Medium Fuel Price'
        ELSE 'High Fuel Price'
    END
ORDER BY total_sales DESC;


/*  Store Performance Classification */
SELECT
    Store,
    SUM(Weekly_Sales) AS total_sales,
    CASE
        WHEN SUM(Weekly_Sales) >= 200000000 THEN 'High Performance'
        WHEN SUM(Weekly_Sales) >= 100000000 THEN 'Medium Performance'
        ELSE 'Low Performance'
    END AS performance_level
FROM walmart_sales
GROUP BY Store
ORDER BY total_sales DESC;


/*  Final KPIs */
SELECT
    COUNT(DISTINCT Store) AS total_stores,
    COUNT(*) AS total_records,
    SUM(Weekly_Sales) AS total_sales,
    AVG(Weekly_Sales) AS avg_weekly_sales,
    MIN([Date]) AS start_date,
    MAX([Date]) AS end_date
FROM walmart_sales;