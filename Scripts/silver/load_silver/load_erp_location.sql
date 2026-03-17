/*
===============================================================================
Stored Procedure: Load ERP Location (Bronze → Silver)
===============================================================================

Description:
This procedure loads and transforms location data into the Silver layer.

Process Overview:
1. Extracts data from bronze.erp_location.
2. Cleans customer IDs.
3. Standardizes country values.
4. Loads data into silver.erp_location.

Key Transformations:
- Removes '-' from customer IDs.
- Standardizes country codes:
    * DE → Germany
    * US / USA → United States
- Replaces NULL or empty values with 'N/A'.

Source Table:
- bronze.erp_location

Target Table:
- silver.erp_location

===============================================================================
*/

USE DataWarehouse;

-- Load ERP Location

INSERT INTO silver.erp_location (
    cid,
    country
)
SELECT 
    REPLACE(cid, '-', ''),

    CASE 
        WHEN TRIM(country) = 'DE' THEN 'Germany'
        WHEN TRIM(country) IN ('US', 'USA') THEN 'United States'
        WHEN TRIM(country) = '' OR country IS NULL THEN 'N/A'
        ELSE TRIM(country)
    END

FROM bronze.erp_location;
---
SELECT * FROM  silver.erp_location;
