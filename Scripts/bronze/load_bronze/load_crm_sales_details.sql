USE DataWarehouse;
GO

/*
===============================================================================
Load CRM Sales Details (CSV → Bronze)
===============================================================================
*/

CREATE PROCEDURE bronze.load_crm_sales_details
AS
BEGIN

    DECLARE @start_time = GETDATE();

    PRINT 'Loading: bronze.crm_sales_details';

    BULK INSERT bronze.crm_sales_details
    FROM 'datasets/source_crm/sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    PRINT 'Completed... ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
---
