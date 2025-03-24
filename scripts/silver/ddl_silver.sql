-- Create DDL for each datasets presents in the sources (CRM and ERP)

-- CRM
	-- cusomers.csv
	-- orders_2023.csv
	-- orders_latest.csv

-- ERP
	-- products.csv
	-- categories.csv

-- First explore each table carefully (data profiling)

-- CRM
	-- customers.csv (6 columns)
		-- cust_id (String)
		-- cust_fname (String)
		-- cust_lname (String)
		-- gender (String)
		-- email (String)
		-- city (String)
	-- orders_2023.csv (5 columns)
		-- ord_id (String)
		-- cust_id (String)
		-- prd_id (String)
		-- qty (Int)
		-- order_date (String)
	-- orders_latest.csv (5 columns)
		-- ord_id (String)
		-- cust_id (String)
		-- prd_id (String)
		-- qty (Int)
		-- order_date (String)

-- ERP
	-- products.csv (5 columns)
		-- prd_id (String)
		-- prd_name (String)
		-- cat_id (String)
		-- price (Int)
		-- cost (Int)
	-- categories.csv
		-- cat_id (String)
		-- cat_name (String)

-- Based on the above exploration create DDL for each datasets

-- CRM
-- customers

IF OBJECT_ID('silver.crm_customers', 'U') IS NOT NULL
	DROP TABLE silver.crm_customers;
GO

-- naming convention schema.source_table_name
CREATE TABLE silver.crm_customers(
	cust_id NVARCHAR(50) NOT NULL,
	cust_fname NVARCHAR(50),
	cust_lname NVARCHAR(50),
	gender NVARCHAR(10),
	email NVARCHAR(50),
	city NVARCHAR(50)
);

IF OBJECT_ID('silver.crm_orders_2023', 'U') IS NOT NULL
	DROP TABLE silver.crm_orders_2023;
GO

-- orders_2023
CREATE TABLE silver.crm_orders_2023(
	ord_id NVARCHAR(50) NOT NULL,
	cust_id NVARCHAR(50) NOT NULL,
	prd_id NVARCHAR(50) NOT NULL,
	qty INT,
	order_date NVARCHAR(50)
);

IF OBJECT_ID('silver.crm_orders_latest', 'U') IS NOT NULL
	DROP TABLE silver.crm_orders_latest;
GO

-- orders_latest
CREATE TABLE silver.crm_orders_latest(
	ord_id NVARCHAR(50) NOT NULL,
	cust_id NVARCHAR(50) NOT NULL,
	prd_id NVARCHAR(50) NOT NULL,
	qty INT,
	order_date NVARCHAR(50)
);

-- ERP
-- products

IF OBJECT_ID('silver.erp_products', 'U') IS NOT NULL
	DROP TABLE silver.erp_products;
GO

CREATE TABLE silver.erp_products(
	prd_id NVARCHAR(50) NOT NULL,
	prd_name NVARCHAR(50),
	cat_id NVARCHAR(50) NOT NULL,
	price INT,
	cost INT
);

-- categories

IF OBJECT_ID('silver.erp_categories', 'U') IS NOT NULL
	DROP TABLE silver.erp_categories;
GO

CREATE TABLE silver.erp_categories(
	cat_id NVARCHAR(50) NOT NULL,
	cat_name NVARCHAR(50)
);