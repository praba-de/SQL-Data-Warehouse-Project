USE DataWarehouse;
GO

/*
===============================================================================
Load CRM Customer Info (CSV → Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_crm_customer_info
AS
BEGIN

    DECLARE @start_time DATETIME = GETDATE();

    PRINT 'Loading: bronze.crm_customer_info';

    TRUNCATE TABLE bronze.crm_customer_info;

    BULK INSERT bronze.crm_customer_info
    FROM 'datasets/source_crm/customer_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    PRINT 'Completed in ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
