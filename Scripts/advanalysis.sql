-- Analyze sales Performance Over Time

SELECT 
YEAR(Order_Date) AS Order_Year,
COUNT(DISTINCT Customer_key) AS Total_Customer,
SUM(Quantity) AS Total_Quantity,
SUM(Sales_Amount) AS Total_Sales
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date);


SELECT 
MONTH(Order_Date) AS Month_Sale,
SUM(Quantity) AS Total_Quantity,
COUNT(DISTINCT Customer_Key) AS Total_Customer,
SUM(Sales_Amount) AS Total_Sales
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL
GROUP BY MONTH(Order_Date)
ORDER BY MONTH(Order_Date);

;
--Aggregate the data progressively over time
--Calculate the Total sales per month
--and the running total of sales over time

SELECT
Month_Date,
Total_Sales,
SUM(Total_Sales) OVER (ORDER BY Month_Date) AS Running_Total,
AVG(Avg_Price) OVER (ORDER BY Month_Date) AS Moving_Avg
FROM (
SELECT 
DATETRUNC (Month, Order_Date) AS Month_Date,
SUM(Sales_Amount) AS Total_Sales,
AVG(Price) AS Avg_Price
FROM gold.fact_sales
WHERE Order_Date IS NOT NULL
GROUP BY DATETRUNC (Month, Order_Date)
)t
;

/*Analyze the yearly performance of product by comparing Each Product sales to 
both it average sales performance and the previous year's sales */

SELECT 
Order_Year,
Product_Name,
Current_Sales,
AVG(Current_Sales) OVER (PARTITION BY Product_Name) AS Avg_Sales,
Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) AS Diff_Avg,
CASE WHEN Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) > 0 THEN 'Above Avg'
	WHEN Current_Sales - AVG(Current_Sales) OVER (PARTITION BY Product_Name) <0 THEN 'Below Avg'
	ELSE 'Avg'
END Avg_Change,
LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) AS Pri_Year,
Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) AS Diff_py,
CASE WHEN Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) > 0 THEN 'Increase'
	WHEN Current_Sales - LAG(Current_Sales) OVER (PARTITION BY Product_Name ORDER BY Order_Year) <0 THEN 'Decrease'
	ELSE 'No Change'
END Py_Change
FROM (
SELECT 
YEAR(s.Order_Date) Order_Year,
p.Product_Name,
SUM(s.Sales_Amount) AS Current_Sales
FROM gold.fact_sales s
LEFT JOIN gold.dim_Poduct p
ON s.Product_key = p.Product_key
WHERE S.Order_Date IS NOT NULL
GROUP BY YEAR(s.Order_Date),
p.Product_Name
)t
ORDER BY Product_Name,
Order_Year
;

--Which categories contribute the most to overall sales
WITH Category_Sales AS (
SELECT 
p.Category,
SUM(s.Sales_Amount) AS Total_Sales
FROM gold.fact_sales s
LEFT JOIN gold.dim_Poduct p
ON p.Product_key = s.Product_key
GROUP BY p.Category
)

SELECT 
Category,
Total_Sales,
SUM(Total_Sales) OVER () Overall_sales,
CONCAT(ROUND((CAST (Total_Sales AS FLOAT) / SUM(Total_Sales) OVER ()) * 100, 2), '%') AS Percentage_of_total
FROM Category_Sales
ORDER BY Total_Sales DESC
;
WITH Product_segement AS (
SELECT 
Product_key,
Product_Name,
Product_Cost,
CASE WHEN Product_Cost < 100 THEN 'Below 100'
	WHEN Product_Cost BETWEEN 100 AND 500 THEN '100-500'
	WHEN Product_Cost BETWEEN 501 AND 999 THEN '501-999'
	ELSE 'Above 1000'
END Cost_Avg
FROM gold.dim_Poduct
)
SELECT 
Cost_Avg,
count(Product_key) AS Total_Product
FROM Product_segement
GROUP BY Cost_Avg
;

/*Group Customer into three segment based on their spending behavior:
	-VIP: Customer with at least 12 months of history and more than 5,000.
	-Regular: Customer with at least 12 months but spending 5,000 or less.
	-New: Customer with a lifespan less than 12 months.
And find the total number of customer byeach group. */

WITH Customer_spending AS (
SELECT  
c.Customer_Key,
SUM(s.Sales_Amount) AS Total_Spending,
MIN(s.Order_Date) AS Fisrt_Date,
MAX(s.Order_Date) AS Last_Date,
DATEDIFF(month, MIN(s.Order_Date), MAX(s.Order_Date)) AS Lifespan
FROM gold.fact_sales s
LEFT JOIN gold.dim_customer c
ON c.Customer_Key = s.Customer_Key
GROUP BY c.Customer_Key
),

segment AS(
SELECT 
Customer_Key,
CASE WHEN Lifespan >= 12 AND Total_Spending > 5000 THEN 'VIP'
	WHEN Lifespan >= 12 AND Total_Spending <= 5000 THEN 'Regular'
	ELSE 'New'
END Cusromer_Segement
FROM Customer_spending
)

SELECT 
Cusromer_Segement,
COUNT(Customer_Key) AS Total_Customer
FROM segment
GROUP BY Cusromer_Segement
ORDER BY Total_Customer DESC 