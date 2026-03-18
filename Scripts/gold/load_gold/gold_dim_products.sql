USE DataWarehouse;
GO

/*
===============================================================================
View: dim_products (Gold Layer)
===============================================================================

Description:
This view creates a product dimension by combining product data from the CRM 
system with category information from the ERP system. It provides a clean, 
analytics-ready dataset for reporting.

Purpose:
- Supports reporting and business analysis.
- Acts as a dimension table in a Star Schema.

Data Sources:
- silver.crm_product_info
- silver.erp_product_category

Key Transformations:
- Generates surrogate key using ROW_NUMBER().
- Joins product data with category details.
- Filters only active products (SCD Type 2 logic).
- Renames columns for analytics-friendly naming.

Business Logic:
- Only current/active records are included 
  (product_end_date IS NULL).
- Category details are enriched from ERP data.

===============================================================================
*/

CREATE VIEW gold.dim_products AS

SELECT 
    -- Surrogate Key
    ROW_NUMBER() OVER (
        ORDER BY pi.product_start_date, pi.product_key
    ) AS product_key,

    -- Business Keys
    pi.product_id AS product_id,
    pi.product_key AS product_number,

    -- Product Details
    pi.product_name AS product_name,

    -- Category Info
    pi.cat_id AS category_id,
    pc.category,
    pc.sub_cat AS subcategory,
    pc.maintenance,

    -- Attributes
    pi.product_cost AS cost,
    pi.product_line,
    pi.product_start_date AS start_date

FROM silver.crm_product_info pi

LEFT JOIN silver.erp_product_category pc
    ON pi.cat_id = pc.id

-- Only Active Products (SCD Type 2)
WHERE pi.product_end_date IS NULL;
