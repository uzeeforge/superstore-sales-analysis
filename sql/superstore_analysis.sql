
-- =============================================
-- Superstore Sales & Profit Analysis
-- Database: SuperstoreAnalysis
-- Tool: Microsoft SQL Server
-- =============================================

USE SuperstoreAnalysis;

-- 1. Overall Sales and Profit
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders;


-- 2. Sales and Profit by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Category
ORDER BY Total_Profit DESC;


-- 3. Sales and Profit by Region
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Region
ORDER BY Total_Profit DESC;


-- 4. Monthly Sales Trend
SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Sales) AS Monthly_Sales
FROM dbo.Orders
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY
    Order_Year,
    Order_Month;


-- 5. Top 10 Products by Sales
SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Product_Name
ORDER BY Total_Sales DESC;


-- 6. Profit by Customer Segment
SELECT
    Segment,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- 7. Profit Margin
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100
        AS Profit_Margin_Percentage
FROM dbo.Orders;


-- 8. Loss-Making Subcategories
SELECT
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM dbo.Orders
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- 9. Discount Impact
SELECT
    Discount,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Profit) AS Average_Profit
FROM dbo.Orders
GROUP BY Discount
ORDER BY Discount;


-- 10. Data Validation
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,

    SUM(CASE
        WHEN Order_Date IS NULL THEN 1
        ELSE 0
    END) AS Missing_Order_Dates,

    SUM(CASE
        WHEN Sales IS NULL THEN 1
        ELSE 0
    END) AS Missing_Sales,

    SUM(CASE
        WHEN Profit IS NULL THEN 1
        ELSE 0
    END) AS Missing_Profit

FROM dbo.Orders;
