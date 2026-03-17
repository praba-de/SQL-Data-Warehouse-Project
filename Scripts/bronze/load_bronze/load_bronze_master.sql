USE DataWarehouse;
GO

/*
===============================================================================
Stored Procedure: Load Bronze Layer (Master Controller)
===============================================================================

Description:
This procedure orchestrates the full Bronze layer loading process by calling 
individual table-level procedures.

Process Overview:
1. Executes all CRM load procedures.
2. Executes all ERP load procedures.
3. Tracks total batch execution time.
4. Handles errors using TRY-CATCH.

===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    DECLARE 
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '=========================================';
        PRINT 'Starting Bronze Layer Load';
        PRINT '=========================================';

        -- CRM
        EXEC bronze.load_crm_customer_info;
        EXEC bronze.load_crm_product_info;
        EXEC bronze.load_crm_sales_details;

        -- ERP
        EXEC bronze.load_erp_customer;
        EXEC bronze.load_erp_location;
        EXEC bronze.load_erp_product_category;

        SET @batch_end_time = GETDATE();

        PRINT '=========================================';
        PRINT 'Bronze Load Completed Successfully';
        PRINT '=========================================';

    END TRY
    BEGIN CATCH
        PRINT 'ERROR: ' + ERROR_MESSAGE();
    END CATCH

END;
