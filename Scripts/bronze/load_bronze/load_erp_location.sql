USE DataWarehouse;
GO

/*
===============================================================================
Load ERP Location (CSV → Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_erp_location
AS
BEGIN

    DECLARE @start_time DATETIME = GETDATE();

    PRINT 'Loading: bronze.erp_location';

    TRUNCATE TABLE bronze.erp_location;

    BULK INSERT bronze.erp_location
    FROM 'datasets/source_erp/LOCATION.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
---
    PRINT 'Completed in ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
