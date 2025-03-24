-- Is the customers table dimension or fact?
-- This is a dimension table because it contains all the descriptive values
-- Each record describe a customer


IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY CUST_ID) AS customer_key -- surrogate key,
	cust_id AS customer_id,
	cust_fname AS customer_first_name,
	cust_lname AS customer_last_name,
	gender,
	email,
	city

FROM silver.crm_customers;

-- Is the orders_2023 and orders_latest tables dimension or fact?
-- This is a fact table because it contains ids, and quantitave values.
-- Each record describe a transaction
IF OBJECT_ID('gold.fact_orders', 'V') IS NOT NULL
	DROP VIEW gold.fact_orders;
GO

CREATE VIEW gold.fact_orders AS
SELECT 
	ord_id AS order_id,
	cust_id AS customer_id,
	prd_id AS product_id,
	qty AS quantity,
	order_date
FROM silver.crm_orders_2023

UNION ALL

SELECT 
	ord_id AS order_id,
	cust_id AS customer_id,
	prd_id AS product_id,
	qty AS quantity,
	order_date
FROM silver.crm_orders_latest;

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY prd_id) AS product_key,
	prd_id AS product_id,
	prd_name AS product_name,
	cat_id AS category_id,
	price,
	cost
FROM silver.erp_products;

IF OBJECT_ID('gold.dim_categories', 'V') IS NOT NULL
	DROP VIEW gold.dim_categories;
GO

CREATE VIEW gold.dim_categories AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY cat_id) AS category_key,
	cat_id AS category_id,
	cat_name AS category_name
FROM silver.erp_categories;
