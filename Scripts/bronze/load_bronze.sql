USE DataWarehouse;
GO

-- ============================================================================
-- Stored Procedure: Load Bronze Layer (Source -> Bronze)
-- ============================================================================
-- Script Purpose:
--   This stored procedure automates the loading of data into the 'bronze' schema 
--   from external CSV files for both CRM (Customer Relationship Management) 
--   and ERP (Enterprise Resource Planning) systems.
--
--   Key actions performed:
--     1. Truncates existing bronze tables before loading new data.
--     2. Loads data from CSV files using BULK INSERT for high-performance batch inserts.
--     3. Logs start and end times, as well as per-table and total batch durations.
--     4. Implements TRY-CATCH error handling to capture and report any loading issues.
--
--   This procedure is intended for initial Bronze layer population or refresh 
--   in a Data Warehouse environment.
--
-- Usage Example:
-- EXEC bronze.load_bronze;
-- ============================================================================

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    DECLARE 
        @start_time DATETIME,
        @end_time DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY

        PRINT '-------------------------------------------------------';
        PRINT 'Loading Bronze Layer';
        PRINT '-------------------------------------------------------';

        SET @batch_start_time = GETDATE();

        PRINT '===========================================================';
        PRINT 'Stored Procedure: Load Bronze Layer (Source -> Bronze)';
        PRINT 'Start Time: ' + CONVERT(VARCHAR, @batch_start_time, 120);
        PRINT '===========================================================';


        -------------------------------------------------------
        -- Loading CRM Tables
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.crm_customer_info';
        TRUNCATE TABLE bronze.crm_customer_info;

        PRINT '>> Inserting Data Into : bronze.crm_customer_info';
        BULK INSERT bronze.crm_customer_info
        FROM 'D:\SQL Project\datasets\source_crm\customer_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.crm_product_info';
        TRUNCATE TABLE bronze.crm_product_info;

        PRINT '>> Inserting Data Into : bronze.crm_product_info';
        BULK INSERT bronze.crm_product_info
        FROM 'D:\SQL Project\datasets\source_crm\product_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\SQL Project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        -------------------------------------------------------
        -- Loading ERP Tables
        -------------------------------------------------------

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.erp_customer';
        TRUNCATE TABLE bronze.erp_customer;

        PRINT '>> Inserting Data Into : bronze.erp_customer';
        BULK INSERT bronze.erp_customer
        FROM 'D:\SQL Project\datasets\source_erp\CUSTOMER.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.erp_location';
        TRUNCATE TABLE bronze.erp_location;

        PRINT '>> Inserting Data Into : bronze.erp_location';
        BULK INSERT bronze.erp_location
        FROM 'D:\SQL Project\datasets\source_erp\LOCATION.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        SET @start_time = GETDATE();

        PRINT '>> Truncating Table : bronze.erp_product_category';
        TRUNCATE TABLE bronze.erp_product_category;

        PRINT '>> Inserting Data Into : bronze.erp_product_category';
        BULK INSERT bronze.erp_product_category
        FROM 'D:\SQL Project\datasets\source_erp\PRDX_CAT.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Duration: ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @start_time, @end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @start_time, @end_time)%60 AS VARCHAR) + 's';

        PRINT '>> -------------';


        -------------------------------------------------------
        -- Batch Completion
        -------------------------------------------------------

        SET @batch_end_time = GETDATE();

        PRINT '===========================================================';
        PRINT 'Loading Bronze Layer Completed Successfully';
        PRINT 'Batch Start Time : ' + CONVERT(VARCHAR, @batch_start_time, 120);
        PRINT 'Batch End Time   : ' + CONVERT(VARCHAR, @batch_end_time, 120);

        PRINT 'Total Duration   : ' +
        CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time)/3600 AS VARCHAR) + 'h ' +
        CAST((DATEDIFF(SECOND, @batch_start_time, @batch_end_time)%3600)/60 AS VARCHAR) + 'm ' +
        CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time)%60 AS VARCHAR) + 's';


    END TRY

    BEGIN CATCH

        SET @batch_end_time = GETDATE();

        PRINT '===========================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message  : ' + ERROR_MESSAGE();
        PRINT 'Error Number   : ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Line     : ' + CAST(ERROR_LINE() AS NVARCHAR(10));

        PRINT 'Batch Start Time: ' + CONVERT(VARCHAR, @batch_start_time, 120);
        PRINT 'Batch End Time  : ' + CONVERT(VARCHAR, @batch_end_time, 120);

        PRINT '===========================================================';

    END CATCH

END;
