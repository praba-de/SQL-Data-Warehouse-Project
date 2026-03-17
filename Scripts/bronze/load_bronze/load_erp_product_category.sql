USE DataWarehouse;
GO

/*
===============================================================================
Load ERP Product Category (CSV → Bronze)
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_erp_product_category
AS
BEGIN

    DECLARE @start_time DATETIME = GETDATE();

    PRINT 'Loading: bronze.erp_product_category';

    TRUNCATE TABLE bronze.erp_product_category;

    BULK INSERT bronze.erp_product_category
    FROM 'datasets/source_erp/PRDX_CAT.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    PRINT 'Completed in ' + 
    CAST(DATEDIFF(SECOND, @start_time, GETDATE()) AS VARCHAR) + ' seconds';

END;
