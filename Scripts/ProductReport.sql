
---Create a Report for Product 
IF OBJECT_ID('gold.report_Product', 'V') IS NOT NULL
    DROP VIEW gold.report_Product;
GO

CREATE VIEW gold.report_Product AS
WITH Base_query AS (
--Retrieves core colums from tables
SELECT 
s.Order_Number,
s.Order_Date,
s.Customer_Key,
s.Sales_Amount,
s.Quantity,
p.Product_key,
p.Product_Name,
p.Category,
p.Subcategory,
p.Product_Cost
FROM gold.fact_sales s
LEFT JOIN gold.dim_Poduct p
ON s.Product_key = p.Product_key
WHERE s.Order_Date IS NOT NULL
)
, Product_aggregation AS (

SELECT
Product_key,
Product_Name,
Category,
Subcategory,
Product_Cost,
DATEDIFF(MONTH, MIN(Order_Date), MAX(Order_Date)) AS Lifespan,
MAX(Order_Date) AS Last_Order,
COUNT(Order_Number) AS Total_Order,
COUNT(Customer_Key) AS Total_Customer,
SUM(Sales_Amount)AS Total_Sales,
SUM(Quantity) AS Total_Quantity,
ROUND(AVG(CAST (Sales_Amount AS float) / COALESCE(Quantity, 0)), 1) AS avg_selling_price
FROM Base_query
GROUP BY Product_key,
	Product_Name,
	Category,
	Subcategory,
	Product_Cost
)

SELECT 
Product_key,
Product_Name,
Category,
Subcategory,
Product_Cost,
Last_Order,
DATEDIFF(Month, Last_Order, GETDATE()) AS Recency_in_months,
CASE WHEN Total_Sales > 50000 THEN 'High Performer'
	WHEN Total_Sales >= 10000 THEN 'Mid Range'
	ELSE 'Low Performer'
END AS Product_segment,
Lifespan,
Total_Order,
Total_Customer,
Total_Sales,
Total_Quantity,
avg_selling_price,
CASE WHEN Total_Order = 0 THEN 0
	ELSE Total_Sales / Total_Order
END AS avg_order_revenue,
CASE WHEN Lifespan = 0 THEN Total_Sales
	ELSE Total_Sales / Lifespan
END AS Avg_monthly_revenue
FROM Product_aggregation
