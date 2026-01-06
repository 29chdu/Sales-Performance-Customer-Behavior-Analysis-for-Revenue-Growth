-- Database Exploration

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customer'

SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Dimenstion Exploration / inorde to get full picture of view

---Find how many items are sold
SELECT SUM(Quantity) AS Total_Quanity FROM gold.fact_sales

---Find the average selling price
SELECT AVG(Price) AS Averege_Price FROM gold.fact_sales;

---Find the total number of order
SELECT COUNT(DISTINCT Order_Number) AS Order_Number FROM gold.fact_sales;

---Find the total number of customer
SELECT COUNT(Customer_Key) AS Total_customer FROM gold.fact_sales;

---Find the total customer how has placed an order 
SELECT COUNT(DISTINCT Customer_Key) AS Customer_how_place_order FROM gold.fact_sales;

-- To Generate a Report that Show all the key metrics of the business.

---Find how many items are sold
SELECT 'Total Sales' AS Measure_Name, SUM(Quantity) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT 'Averege Price' AS Measure_Name, AVG(Price) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT 'Order Number' AS Measyre_Name, COUNT(DISTINCT Order_Number) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT 'Total Customer' AS Measure_Name, COUNT(Customer_Key) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT 'Customer_how_place_order' AS Measure_Name, COUNT(DISTINCT Customer_Key) AS Measure_Value FROM gold.fact_sales;


