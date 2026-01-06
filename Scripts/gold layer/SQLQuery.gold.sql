---Create a dimanition customer 
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customer AS 
SELECT  
	ROW_NUMBER () OVER (ORDER BY cst_id) AS Customer_Key,
	ci.cst_id AS Customer_id,
	ci.cst_key AS Customer_Number,
	ci.cst_firstname AS First_Name,
	ci.cst_lastname AS Last_Name,
	la.CNTRY AS Counrty,
CASE WHEN ci.cst_gndr !='n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.GEN, 'n/a')
END AS Gender,
	ci.cst_marital_status AS Marital_Status,
	ca.BDATE Birthday_Date,
	ci.cst_create_date AS Create_Date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca
	ON ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
	ON ci.cst_key = la.CID;

-- Creating a dimation product
IF OBJECT_ID('gold.dim_Poduct', 'V') IS NOT NULL
    DROP VIEW gold.dim_Poduct;
GO
CREATE VIEW gold.dim_Poduct AS 
SELECT 
	ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt,pn.prd_key) AS Product_key,
	pn.prd_id AS Product_Id,
	pn.cat_id AS Category_Id,
	pn.prd_key AS Product_Number,
	pn.prd_nm AS Product_Name,
	pn.prd_cost AS Product_Cost,
	pn.prd_line AS Product_Line,
	pc.CAT AS Category,
	pc.SUBCAT AS Subcategory,
	pc.MAINTENANCE AS Product_Maintenance,
	pn.prd_start_dt AS Start_Date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
	ON pn.cat_id = pc.ID
WHERE pn.prd_end_dt is null;

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;

CREATE VIEW gold.fact_sales AS
SELECT 
	sd.sls_ord_num AS Order_Number,
	pr.Product_key,
	cu.Customer_Key,
	sd.sls_order_dt AS Order_Date,
	sd.sls_ship_dt AS Shipping_Date,
	sd.sls_due_dt AS Due_Date,
	sd.sls_sales AS Sales_Amount,
	sd.sls_quantity AS Quantity,
	sd.sls_price AS Price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_Poduct pr
	ON sd.sls_prd_key = pr.Product_Number
LEFT JOIN gold.dim_customer cu
	ON sd.sls_cust_id = cu.Customer_id;
	