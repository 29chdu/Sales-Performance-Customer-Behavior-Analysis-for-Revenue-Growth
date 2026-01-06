INSERT INTO silver.crm_cust_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)

SELECT 
cst_id,
cst_key,
--Check for unwanted sapce for first name, last name and gender
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
--Data qulity 
	CASE WHEN UPPER(cst_marital_status) = 'M' THEN 'Married'
		WHEN UPPER(cst_marital_status) = 'S' THEN 'Single'
		ELSE 'n/a' 
	END cst_marital_status, -- Normalize marital status to the readable format
	CASE WHEN UPPER(cst_gndr) = 'M' THEN 'Male'
		when UPPER(cst_gndr) = 'F' THEN 'Female'
		ELSE 'n/a'
	END cst_gndr, -- Normalize gender to the readable format
cst_create_date
FROM (
--Removing all Duplicate enrty in the customer and null 
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS ROW_NO
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL
)t WHERE ROW_NO = 1 ;-- Select the most recent record per customer


INSERT INTO silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id, -- Extract category Id
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key, -- Extract product key
prd_nm,
COALESCE(prd_cost, 0) AS prd_cost,
	CASE WHEN UPPER(prd_line) = 'M' THEN 'Mountain'
		WHEN UPPER(prd_line) = 'S' THEN 'Other Sales'
		WHEN UPPER(prd_line) = 'R' THEN 'Road'
		WHEN UPPER(prd_line) = 'T' THEN 'Touring'
		ELSE 'Not Applicable'
	END prd_line, -- Map product line code to desriptive valeu
CAST(prd_start_dt AS DATE)AS prd_start_dt,
CAST(LEAD (prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 
	AS DATE) AS prd_end_dt -- Calculate end date os one day before next start date
FROM bronze.crm_prd_info;


INSERT INTO silver.crm_sales_details (
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)

SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt =0 OR LEN(sls_order_dt) !=8 THEN NULL
	ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
END sls_order_dt,
CASE WHEN sls_ship_dt =0 OR LEN(sls_ship_dt) !=8 THEN NULL
	ELSE CAST(CAST(sls_ship_dt AS VARCHAR)AS DATE)
END sls_ship_dt,
CASE WHEN sls_due_dt =0 OR LEN(sls_due_dt) !=8 THEN NULL
	ELSE CAST(CAST(sls_due_dt AS VARCHAR)AS DATE)
END sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity*ABS(sls_price)
		THEN sls_quantity*ABS(sls_price)
	ELSE sls_sales
END sls_sales, --Recalculate sales if original value is missing or incorrect
sls_quantity,
CASE WHEN sls_price IS NULL OR sls_price <=0
			THEN sls_sales / NULLIF(sls_quantity,0)
		ELSE sls_price
END sls_price -- Derve price if original vallue is invalid
FROM bronze.crm_sales_details;


INSERT INTO silver.erp_CUST_AZ12 (
CID,
BDATE,
GEN
)

SELECT
CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LEN(CID))
	ELSE CID
END CID,
CASE WHEN BDATE > GETDATE () THEN NULL
	ELSE BDATE
END BDATE, -- set a future birthday to null
CASE WHEN TRIM(GEN) IN ('M', 'MALE') THEN 'Male'
	WHEN TRIM(GEN) IN ( 'F', 'FEMALE') THEN 'Female'
ELSE 'n/a'
END AS GEN -- Normalize gender valure and handle unknow case
FROM bronze.erp_CUST_AZ12


INSERT INTO silver.erp_LOC_A101 (
CID,
CNTRY
)

SELECT 
REPLACE(CID, '-','') AS CID,
CASE WHEN CNTRY IN ('US', 'United States') THEN 'United States'
	WHEN CNTRY = 'DE' THEN 'Denmark'
	WHEN CNTRY IS NULL OR CNTRY = '' THEN 'n/a'
	ELSE CNTRY
END CNTRY
FROM bronze.erp_LOC_A101;


INSERT INTO silver.erp_PX_CAT_G1V2(
ID,
CAT,
SUBCAT,
MAINTENANCE
)

SELECT * FROM bronze.erp_PX_CAT_G1V2
;