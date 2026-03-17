USE DataWarehouse;
GO

/*
===============================================================================
Load CRM Product Info (CSV → Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_crm_product_info
AS
BEGIN

    DECLARE @start_time DATETIME = GETDATE();

    PRINT 'Loading: bronze.crm_product_info';

    TRUNCATE TABLE bronze.crm_product_info;

    BULK INSERT bronze.crm_product_info
    FROM 'datasets/source_crm/product_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
---
    PRINT 'Completed in ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
