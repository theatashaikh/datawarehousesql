SELECT *
FROM silver.crm_customers;
-------------------------------------------------
-- cust_id
-------------------------------------------------
-- Check if the cust_id column has any duplicates
-- Expectation: No records
SELECT cust_id, COUNT(*) value_counts
FROM silver.crm_customers
GROUP BY cust_id
HAVING COUNT(*) > 1;

-- Check if the values of the cust_id column has any white spaces
-- Expectation: No records
SELECT cust_id
FROM silver.crm_customers
WHERE cust_id != TRIM(cust_id);

-- Check if the cust_id column has any missing(null) values
-- Expectation: No records
SELECT cust_id
FROM silver.crm_customers
WHERE cust_id IS NULL;

-------------------------------------------------
-- cust_fname
-------------------------------------------------
-- Check if the values of the cust_fname column has any null values
-- Expectation: No records
SELECT cust_fname
FROM silver.crm_customers
WHERE cust_fname IS NULL;

-- Check if the values of the cust_fname column has any white spaces
-- Expectation: No records
SELECT cust_fname
FROM silver.crm_customers
WHERE cust_fname != TRIM(cust_fname);
-------------------------------------------------
-- cust_lname
-------------------------------------------------
-- Check if the values of the cust_lname column has any null values
-- Expectation: No records
SELECT cust_lname
FROM silver.crm_customers
WHERE cust_lname IS NULL;

-- Check if the values of the cust_lname column has any white spaces
-- Expectation: No records
SELECT cust_lname
FROM silver.crm_customers
WHERE cust_lname != TRIM(cust_lname);
-------------------------------------------------
-- gender
-------------------------------------------------
-- Gender is low cardinality column type. Means it can only few types of values, so let's check what are they
-- Expectation: male, female, unknown.
SELECT DISTINCT gender
FROM silver.crm_customers;

--------------------------------------------
-- email
--------------------------------------------
-- Check if we have any null values in email
-- Expectation: No records
SELECT 
	email
FROM silver.crm_customers
WHERE email IS NULL;

-- Check if we have any white spaces in email
-- Expectation: No records
SELECT 
	email
FROM silver.crm_customers
WHERE email != TRIM(email);

-------------------------------------------------
-- city
-------------------------------------------------
-- Check if the values of the city column has any null values
-- Expectation: No records
SELECT city
FROM silver.crm_customers
WHERE city IS NULL;

-- Check if the values of the cust_fname column has any white spaces
-- Expectation: No records
SELECT city
FROM silver.crm_customers
WHERE city != TRIM(city);
