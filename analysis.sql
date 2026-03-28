-- ============================================================
-- E-Commerce SQL Analysis
-- Dataset: UCI Online Retail (online_retail.csv)
-- Tool:    DuckDB / DataCamp DataLab
-- Author:  swezinye
-- ============================================================


-- ------------------------------------------------------------
-- 01. Explore the data
--     Preview the first 10 rows of the raw dataset
-- ------------------------------------------------------------
SELECT *
FROM "online_retail.csv"
LIMIT 10;


-- ------------------------------------------------------------
-- 02. Data Quality: Total row count
--     Verify how many records are in the dataset
-- ------------------------------------------------------------
SELECT COUNT(*) AS total_rows
FROM 'online_retail.csv';


-- ------------------------------------------------------------
-- 03. Data Quality: Missing CustomerIDs
--     Count how many rows have no customer identifier
-- ------------------------------------------------------------
SELECT COUNT(*) AS missing_customer_ids
FROM "online_retail.csv"
WHERE CustomerID IS NULL;


-- ------------------------------------------------------------
-- 04. Clean Dataset
--     Parse timestamps and remove rows with null CustomerID
-- ------------------------------------------------------------
WITH clean_retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header            = true,
        timestampformat   = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
)
SELECT *
FROM clean_retail
LIMIT 10;


-- ------------------------------------------------------------
-- 05. Which countries generate the most revenue?
--     Aggregate total sales (Quantity x UnitPrice) by country
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
      AND Quantity      > 0
      AND UnitPrice     > 0
)
SELECT
    Country,
    COUNT(DISTINCT InvoiceNo)          AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_sales
FROM retail
GROUP BY Country
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 06. Who are the top customers?
--     Rank customers by their total spend
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
      AND Quantity  > 0
      AND UnitPrice > 0
)
SELECT
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo)           AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
FROM retail
GROUP BY CustomerID, Country
ORDER BY total_spent DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 07. What products sell the most?
--     Find top 10 best-selling products by quantity sold
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
      AND Quantity  > 0
      AND UnitPrice > 0
)
SELECT
    StockCode,
    Description,
    SUM(Quantity)                       AS total_quantity_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM retail
GROUP BY StockCode, Description
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 08. How much customer data is missing?
--     Missing CustomerID rate broken down by country
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
)
SELECT
    Country,
    COUNT(*)                                                        AS total_rows,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END)            AS missing_customer_ids,
    ROUND(
        SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*),
        2
    )                                                               AS missing_percentage
FROM retail
GROUP BY Country
ORDER BY missing_customer_ids DESC;


-- ------------------------------------------------------------
-- 09. Monthly sales trend
--     How does revenue change month over month?
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
      AND Quantity  > 0
      AND UnitPrice > 0
)
SELECT
    STRFTIME(InvoiceDate, '%Y-%m')      AS year_month,
    COUNT(DISTINCT InvoiceNo)           AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue
FROM retail
GROUP BY year_month
ORDER BY year_month ASC;


-- ------------------------------------------------------------
-- 10. Average order value by country
--     Which countries have the highest spend per order?
-- ------------------------------------------------------------
WITH retail AS (
    SELECT *
    FROM read_csv('online_retail.csv',
        header          = true,
        timestampformat = '%m/%d/%y %H:%M'
    )
    WHERE CustomerID IS NOT NULL
      AND Quantity  > 0
      AND UnitPrice > 0
),
order_totals AS (
    SELECT
        Country,
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_value
    FROM retail
    GROUP BY Country, InvoiceNo
)
SELECT
    Country,
    COUNT(InvoiceNo)                    AS total_orders,
    ROUND(AVG(order_value), 2)          AS avg_order_value,
    ROUND(SUM(order_value), 2)          AS total_revenue
FROM order_totals
GROUP BY Country
ORDER BY avg_order_value DESC
LIMIT 15;
