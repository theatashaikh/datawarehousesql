/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_end_time = GETDATE();
		PRINT '==============================================='
		PRINT 'LOADING BRONZE LAYER'
		PRINT '==============================================='

		PRINT '-----------------------------------------------'
		PRINT 'LOADING CRM TABLES'
		PRINT '-----------------------------------------------'
		
		PRINT '>>> TRUNCATING TABLE: crm_customers'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_customers;

		PRINT '>>> INSERTING DATA INTO: crm_customers'
		BULK INSERT bronze.crm_customers
		FROM 'C:\Users\atash\Downloads\data-engineering\royalwoool\datasets\crm\customers.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

		PRINT '-----------------------------------------------'

		PRINT '>>> TRUNCATING TABLE: crm_orders_2023'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_orders_2023;

		PRINT '>>> INSERTING DATA INTO: crm_orders_2023'
		BULK INSERT bronze.crm_orders_2023
		FROM 'C:\Users\atash\Downloads\data-engineering\royalwoool\datasets\crm\orders_2023.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

		PRINT '-----------------------------------------------'

		PRINT '>>> TRUNCATING TABLE: crm_orders_latest'

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.crm_orders_latest;

		PRINT '>>> INSERTING DATA INTO: crm_orders_latest'
		BULK INSERT bronze.crm_orders_latest
		FROM 'C:\Users\atash\Downloads\data-engineering\royalwoool\datasets\crm\orders_latest.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

		PRINT '-----------------------------------------------'
		PRINT 'LOADING ERP TABLES'
		PRINT '-----------------------------------------------'

		PRINT '>>> TRUNCATING TABLE: erp_products'

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_products;

		PRINT '>>> INSERTING DATA INTO: erp_products'
		BULK INSERT bronze.erp_products
		FROM 'C:\Users\atash\Downloads\data-engineering\royalwoool\datasets\erp\products.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'

		PRINT '-----------------------------------------------'

		PRINT '>>> TRUNCATING TABLE: erp_categories'

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_categories;

		PRINT '>>> INSERTING DATA INTO: erp_categories'
		BULK INSERT bronze.erp_categories
		FROM 'C:\Users\atash\Downloads\data-engineering\royalwoool\datasets\erp\categories.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Duration: '+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' seconds.'
		PRINT '-------------------------------------------------'
		SET @batch_end_time = GETDATE();
		PRINT 'Total duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds.';
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END

-- SELECT TOP(10) * FROM bronze.crm_customers;