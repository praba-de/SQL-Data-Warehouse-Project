USE DataWarehouse;
GO

/*
===============================================================================
View: dim_customers (Gold Layer)
===============================================================================

Description:
This view creates a dimensional model for customers by combining CRM and ERP 
data from the Silver layer. It provides a unified and analytics-ready 
customer dataset.

Purpose:
- Supports reporting and analytics use cases.
- Serves as a dimension table in a Star Schema.

Data Sources:
- silver.crm_customer_info
- silver.erp_customer
- silver.erp_location

Key Transformations:
- Generates surrogate key using ROW_NUMBER().
- Combines CRM and ERP customer data.
- Resolves gender using fallback logic.
- Adds country information from ERP location.
- Standardizes column naming for analytics.

Business Logic:
- Gender is prioritized from CRM; if missing, fallback to ERP.
- Customer key is generated as a surrogate key for dimension usage.

===============================================================================
*/

CREATE VIEW gold.dim_customers AS

SELECT
    -- Surrogate Key
    ROW_NUMBER() OVER (ORDER BY ci.customer_id) AS customer_key,

    -- Business Keys
    ci.customer_id AS customer_id,
    ci.customer_key AS customer_number,

    -- Customer Details
    ci.customer_firstname AS first_name,
    ci.customer_lastname AS last_name,

    -- Location
    loc.country AS country,

    -- Attributes
    ci.customer_marital_status AS marital_status,

    -- Gender Logic
    CASE 
        WHEN ci.customer_gender != 'N/A' THEN ci.customer_gender
        ELSE COALESCE(cus.gender, 'N/A')
    END AS gender,

    -- Additional Info
    cus.birth_date AS birthdate,
    ci.customer_create_date AS create_date

FROM silver.crm_customer_info ci

LEFT JOIN silver.erp_customer cus
    ON ci.customer_key = cus.cid

LEFT JOIN silver.erp_location loc
    ON ci.customer_key = loc.cid;
