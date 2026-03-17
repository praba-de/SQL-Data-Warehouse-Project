/*
===============================================================================
Stored Procedure: Load ERP Product Category (Bronze → Silver)
===============================================================================

Description:
This procedure loads product category data into the Silver layer without 
major transformations.

Process Overview:
1. Extracts data from bronze.erp_product_category.
2. Loads data directly into silver.erp_product_category.

Key Transformations:
- Minimal transformation (direct load).

Source Table:
- bronze.erp_product_category

Target Table:
- silver.erp_product_category

===============================================================================
*/

USE DataWarehouse;

-- Load ERP Product Category

INSERT INTO silver.erp_product_category (
    id,
    category,
    sub_cat,
    maintenance
)
SELECT 
    id,
    category,
    sub_cat,
    maintenance
FROM bronze.erp_product_category;
---
SELECT * FROM silver.erp_product_category;
