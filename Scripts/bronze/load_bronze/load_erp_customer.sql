USE DataWarehouse;
GO

/*
===============================================================================
Load ERP Customer (CSV → Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_erp_customer
AS
BEGIN

    DECLARE @start_time DATETIME = GETDATE();

    PRINT 'Loading: bronze.erp_customer';

    TRUNCATE TABLE bronze.erp_customer;

    BULK INSERT bronze.erp_customer
    FROM 'datasets/source_erp/CUSTOMER.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    PRINT 'Completed in ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
