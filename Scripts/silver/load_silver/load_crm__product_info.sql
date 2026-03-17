/*
===============================================================================
Stored Procedure: Load CRM Product Info (Bronze → Silver)
===============================================================================

Description:
This procedure loads and transforms product data from the Bronze layer 
into the Silver layer.

Process Overview:
1. Extracts data from bronze.crm_product_info.
2. Derives category ID from product_key.
3. Cleans and standardizes product attributes.
4. Applies Slowly Changing Dimension (SCD Type 2) logic.
5. Loads data into silver.crm_product_info.

Key Transformations:
- Extracts cat_id from product_key.
- Replaces missing product_cost with 0.
- Standardizes product_line values:
    * M → Mountain
    * R → Road
    * S → Other Sales
    * T → Touring
- Converts product_start_date to DATE.
- Calculates product_end_date using LEAD().

Source Table:
- bronze.crm_product_info

Target Table:
- silver.crm_product_info

===============================================================================
*/

USE DataWarehouse;

-- Load CRM Product Info

INSERT INTO silver.crm_product_info (
    product_id,
    cat_id,
    product_key,
    product_name,
    product_cost,
    product_line,
    product_start_date,
    product_end_date
)
SELECT
    product_id,

    -- Extract Category ID
    REPLACE(SUBSTRING(product_key, 1, 5), '-', '_') AS cat_id,

    SUBSTRING(product_key, 7, LEN(product_key)) AS product_key,
    product_name,

    ISNULL(product_cost, 0) AS product_cost,

    -- Standardize Product Line
    CASE 
        WHEN UPPER(TRIM(product_line)) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(product_line)) = 'R' THEN 'Road'
        WHEN UPPER(TRIM(product_line)) = 'S' THEN 'Other Sales'
        WHEN UPPER(TRIM(product_line)) = 'T' THEN 'Touring'
        ELSE 'N/A'
    END AS product_line,

    CAST(product_start_date AS DATE),

    -- SCD Type 2 Logic
    DATEADD(
        DAY, -1,
        LEAD(product_start_date)
        OVER (PARTITION BY product_key ORDER BY product_start_date)
    ) AS product_end_date

FROM bronze.crm_product_info;
---
select * from silver.crm_product_info;
---
