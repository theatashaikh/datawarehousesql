/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure transforms data from the 'bronze' schema into the 'silver' schema.
    It performs the following transformations:
    - Standardizes customer data (names to uppercase, gender normalized, emails to lowercase)
    - Reformats date fields from DD/MM/YYYY to YYYY-MM-DD format
    - Trims and standardizes product and category names
    - Cleans category IDs by removing leading zeros

Parameters:
    None. 
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '==============================================='
        PRINT 'LOADING SILVER LAYER'
        PRINT '==============================================='

        PRINT '-----------------------------------------------'
        PRINT 'TRANSFORMING CRM TABLES'
        PRINT '-----------------------------------------------'
        
        PRINT '>>> TRUNCATING TABLE: silver.crm_customers'
        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.crm_customers;

        PRINT '>>> INSERTING DATA INTO: silver.crm_customers'
        INSERT INTO silver.crm_customers(
            cust_id,
            cust_fname,
            cust_lname,
            gender,
            email,
            city
        )
        SELECT
            cust_id,
            UPPER(cust_fname) cust_fname,
            UPPER(cust_lname) cust_lname,
            TRIM(LOWER(COALESCE(CASE TRIM(LOWER(gender))
                WHEN 'F' THEN 'female'
                WHEN 'M' THEN 'male'
                ELSE gender
            END, 'unknown'))) as gender,
            LOWER(email) email,
            LOWER(TRIM(COALESCE(city, 'unknown'))) city
        FROM bronze.crm_customers;

        SET @end_time = GETDATE();
        PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

        PRINT '-----------------------------------------------'

        PRINT '>>> TRUNCATING TABLE: silver.crm_orders_2023'
        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.crm_orders_2023;

        PRINT '>>> INSERTING DATA INTO: silver.crm_orders_2023'
        INSERT INTO silver.crm_orders_2023(
            ord_id,
            cust_id,
            prd_id,
            qty,
            order_date
        )
        SELECT
            ord_id,
            cust_id,
            prd_id,
            qty,
            CONCAT(SUBSTRING(order_date, 7, 4), '-', SUBSTRING(order_date, 4, 2), '-', SUBSTRING(order_date, 1, 2)) order_date
        FROM bronze.crm_orders_2023;

        SET @end_time = GETDATE();
        PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

        PRINT '-----------------------------------------------'

        PRINT '>>> TRUNCATING TABLE: silver.crm_orders_latest'
        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.crm_orders_latest;

        PRINT '>>> INSERTING DATA INTO: silver.crm_orders_latest'
        INSERT INTO silver.crm_orders_latest(
            ord_id,
            cust_id,
            prd_id,
            qty,
            order_date
        )
        SELECT
            ord_id,
            cust_id,
            prd_id,
            qty,
            CONCAT(SUBSTRING(order_date, 7, 4), '-', SUBSTRING(order_date, 4, 2), '-', SUBSTRING(order_date, 1, 2)) order_date
        FROM bronze.crm_orders_latest;

        SET @end_time = GETDATE();
        PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

        PRINT '-----------------------------------------------'
        PRINT 'TRANSFORMING ERP TABLES'
        PRINT '-----------------------------------------------'

        PRINT '>>> TRUNCATING TABLE: silver.erp_products'
        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.erp_products;

        PRINT '>>> INSERTING DATA INTO: silver.erp_products'
        INSERT INTO silver.erp_products(
            prd_id,
            prd_name,
            cat_id,
            price,
            cost
        )
        SELECT 
            prd_id,
            LOWER(TRIM(prd_name)) prd_name,
            cat_id,
            price,
            cost
        FROM bronze.erp_products;

        SET @end_time = GETDATE();
        PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

        PRINT '-----------------------------------------------'

        PRINT '>>> TRUNCATING TABLE: silver.erp_categories'
        SET @start_time = GETDATE();
        TRUNCATE TABLE silver.erp_categories;

        PRINT '>>> INSERTING DATA INTO: silver.erp_categories'
        INSERT INTO silver.erp_categories(
            cat_id,
            cat_name
        )
        SELECT 
            REPLACE(cat_id, '0', '') cat_id,
            LOWER(TRIM(cat_name)) cat_name
        FROM bronze.erp_categories;
        
        SET @end_time = GETDATE();
        PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'
        PRINT '-------------------------------------------------'
        SET @batch_end_time = GETDATE();
        PRINT 'Total duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds.';
    END TRY
    BEGIN CATCH
        PRINT '=========================================='
        PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=========================================='
    END CATCH

END