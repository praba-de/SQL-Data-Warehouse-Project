USE DataWarehouse;
GO

/*
===============================================================================
Load CRM Customer Info (CSV → Bronze)
===============================================================================
*/

CREATE PROCEDURE bronze.load_crm_customer_info
AS
BEGIN

    DECLARE @start_time = GETDATE();

    PRINT 'Loading: bronze.crm_customer_info';

    BULK INSERT bronze.crm_customer_info
    FROM 'datasets/source_crm/customer_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    PRINT 'Completed...' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
---
