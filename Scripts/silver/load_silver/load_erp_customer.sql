/*
===============================================================================
Stored Procedure: Load ERP Customer (Bronze → Silver)
===============================================================================

Description:
This procedure loads and transforms ERP customer data into the Silver layer.

Process Overview:
1. Extracts data from bronze.erp_customer.
2. Cleans customer IDs.
3. Validates birth dates.
4. Standardizes gender values.
5. Loads data into silver.erp_customer.

Key Transformations:
- Removes 'NAS' prefix from customer IDs.
- Replaces future birth dates with NULL.
- Standardizes gender values:
    * Male / Female / N/A

Source Table:
- bronze.erp_customer

Target Table:
- silver.erp_customer

===============================================================================
*/

USE DataWarehouse;

-- Load ERP Customer

INSERT INTO silver.erp_customer (
    cid,
    birth_date,
    gender
)
SELECT
    CASE 
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
        ELSE cid
    END,

    CASE 
        WHEN birth_date > GETDATE() THEN NULL
        ELSE birth_date
    END,

    CASE 
        WHEN UPPER(TRIM(gender)) IN ('F', 'Female') THEN 'Female'
        WHEN UPPER(TRIM(gender)) IN ('M', 'Male') THEN 'Male'
        ELSE 'N/A'
    END

FROM bronze.erp_customer;

SELECT * FROM silver.erp_customer;
