USE DataWarehouse;
GO

/*
===============================================================================
View: fact_sales (Gold Layer)
===============================================================================

Description:
This view creates the central fact table for sales by combining transactional 
data from the CRM system with dimension tables for customers and products.

Purpose:
- Supports analytical queries and reporting.
- Acts as the central fact table in a Star Schema.

Data Sources:
- silver.crm_sales_details
- gold.dim_products
- gold.dim_customers

Key Transformations:
- Joins transactional sales data with dimension tables.
- Maps business keys to surrogate keys.
- Renames columns for analytics-friendly usage.

Business Logic:
- Each record represents a sales transaction.
- Links to:
    * dim_customers via customer_key
    * dim_products via product_key

===============================================================================
*/

CREATE VIEW gold.fact_sales AS

SELECT 
    -- Order Info
    sd.sales_order_num AS order_number,

    -- Foreign Keys (Dimension Keys)
    dp.product_key,
    dc.customer_key,

    -- Dates
    sd.sales_order_date AS order_date,
    sd.sales_ship_date AS shipping_date,
    sd.sales_due_date AS due_date,

    -- Measures
    sd.sales_sales AS sales_amount,
    sd.sales_quantity AS quantity,
    sd.sales_price AS price

FROM silver.crm_sales_details sd 

LEFT JOIN gold.dim_products dp
    ON sd.sales_product_key = dp.product_number

LEFT JOIN gold.dim_customers dc
    ON sd.sales_customer_id = dc.customer_id;
