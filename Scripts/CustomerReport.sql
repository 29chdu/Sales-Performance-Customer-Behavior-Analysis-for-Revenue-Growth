---Create a Report for customer 
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO
CREATE VIEW gold.report_customers AS 

-- Customer Report 
WITH Base_query AS (
--Retrieves core colums from tables
SELECT 
s.Order_Number,
s.Product_key,
s.Order_Date,
s.Sales_Amount,
s.Quantity,
c.Customer_Key,
c.Customer_Number,
CONCAT(c.First_Name, ' ', c.Last_Name) AS Customer_Name,
DATEDIFF(Year, c.Birthday_Date, GETDATE()) AS Age
FROM gold.fact_sales s
LEFT JOIN gold.dim_customer c
ON c.Customer_Key = s.Customer_Key
WHERE s.Order_Date IS NOT NULL
)

, Customer_aggregation AS (

--Customer Aggregation: Summarizes key metrics at the customer level
SELECT 
Customer_Key,
Customer_Number,
Customer_Name,
Age,
COUNT(DISTINCT Order_Number) AS Total_Orders,
COUNT(DISTINCT Product_key) AS Total_Product,
SUM(Sales_Amount) AS Total_Sales,
SUM(Quantity) Total_Quantity,
MAX(Order_Date) AS Last_Order,
DATEDIFF(Month, MIN(Order_Date), MAX(Order_Date)) AS Lifespan
FROM Base_query
GROUP BY Customer_Key,
	Customer_Number,
	Customer_Name,
	Age
)

SELECT 
Customer_Key,
Customer_Number,
Customer_Name,
Age,
CASE WHEN Age < 30 THEN 'Under 30'
	WHEN Age BETWEEN 30 AND 39 THEN '30-39'
	WHEN Age BETWEEN 40 AND 49 THEN '40-49'
	WHEN Age BETWEEN 50 AND 59 THEN '50-59'
	WHEN Age BETWEEN 60 AND 69 THEN '60-69'
	ELSE 'Above 70'
END Age_group,
Total_Orders,
Total_Product,
Total_Sales,
Total_Quantity,
CASE WHEN Lifespan >= 12 AND Total_Sales > 5000 THEN 'VIP'
	WHEN Lifespan >= 12 AND Total_Sales <= 5000 THEN 'Regular'
	ELSE 'New'
END Cusromer_Segement,
DATEDIFF(Month, Last_Order, GETDATE()) AS Recenty,
Last_Order,
Lifespan,
CASE WHEN Total_Sales = 0 THEN 0
	ELSE Total_Sales/ Total_Orders
END AS avg_order_value,
CASE WHEN Lifespan = 0 THEN Total_Sales
	WHEN Total_Sales = 0 THEN 0
	ELSE Total_Sales / Lifespan
END AS avg_monthyl_spend
FROM Customer_aggregation
