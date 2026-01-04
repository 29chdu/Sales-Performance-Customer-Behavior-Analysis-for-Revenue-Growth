-- To Create a Database 

IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='Sales_DB')
BEGIN 
	ALTER DATABASE Sales_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Sales_DB;
END;
GO

CREATE DATABASE Sales_DB
GO

USE Sales_DB;
GO

-- Create of Schema

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info (
cst_id INT,
cst_key NVARCHAR (50),
cst_firstname NVARCHAR (50),
cst_lastname NVARCHAR (50),
cst_marital_status NVARCHAR (12),
cst_gndr NVARCHAR (12),
cst_create_date DATE
);

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info (
prd_id INT,
cat_id NVARCHAR (50),
prd_key NVARCHAR (50),
prd_nm NVARCHAR (50),
prd_cost INT,
prd_line VARCHAR (15),
prd_start_dt DATE,
prd_end_dt DATE
);

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details (
sls_ord_num  NVARCHAR (20),
sls_prd_key NVARCHAR(20),
sls_cust_id INT,
sls_order_dt DATE,
sls_ship_dt DATE,
sls_due_dt DATE,
sls_sales INT,
sls_quantity INT,
sls_price INT
);

IF OBJECT_ID('silver.erp_CUST_AZ12', 'U') IS NOT NULL
	DROP TABLE silver.erp_CUST_AZ12;
CREATE TABLE silver.erp_CUST_AZ12 (
CID NVARCHAR (25),
BDATE DATE,
GEN NVARCHAR (15)
);

IF OBJECT_ID('silver.erp_LOC_A101', 'U') IS NOT NULL
	DROP TABLE silver.erp_LOC_A101;
CREATE TABLE silver.erp_LOC_A101 (
CID NVARCHAR (25),
CNTRY NVARCHAR (25)
);

IF OBJECT_ID('silver.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	DROP TABLE silver.erp_PX_CAT_G1V2;
CREATE TABLE silver.erp_PX_CAT_G1V2 (
ID NVARCHAR	(12),
CAT	NVARCHAR (50),
SUBCAT	NVARCHAR (50),
MAINTENANCE	NVARCHAR  (10)
);

-- We are going to use BULK INSERT to move data from csv file to Sql server 
-- End create a command for using to insert data automatic 

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	TRUNCATE TABLE bronze.crm_cust_info;
	BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW =2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR ='\n',
			TABLOCK
			);

	TRUNCATE TABLE bronze.crm_prd_info;
	BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR ='\n',
			TABLOCK
			);

	TRUNCATE TABLE bronze.crm_sales_details;
	BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR ='\n',
			TABLOCK
		);

	TRUNCATE TABLE bronze.erp_CUST_AZ12;
	BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_erp\CUST_AZ12.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR ='\n',
			TABLOCK
		);

	TRUNCATE TABLE bronze.erp_LOC_A101;
	BULK INSERT bronze.erp_LOC_A101
		FROM'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_erp\LOC_A101.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR= '\n',
			TABLOCK
		);
	TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
	BULK INSERT bronze.erp_PX_CAT_G1V2
	FROM 'C:\Users\Japhary\Desktop\Data Analysis\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW =2,
		FIELDTERMINATOR =',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
END

SELECT * FROM bronze.crm_cust_info;
SELECT * FROM bronze.crm_prd_info;
SELECT * FROM bronze.crm_sales_details;

SELECT * FROM bronze.erp_CUST_AZ12;
SELECT * FROM bronze.erp_LOC_A101;
SELECT * FROM bronze.erp_PX_CAT_G1V2;







 

