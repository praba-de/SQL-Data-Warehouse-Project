/*
===============================================================================
Stored Procedure: Load CRM Sales Details (Bronze → Silver)
===============================================================================

Description:
This procedure loads and transforms sales transaction data from the Bronze 
layer into the Silver layer.

Process Overview:
1. Extracts data from bronze.crm_sales_details.
2. Cleans invalid date formats.
3. Validates and recalculates sales values.
4. Fixes missing or incorrect pricing data.
5. Loads data into silver.crm_sales_details.

Key Transformations:
- Converts integer-based dates into DATE format.
- Replaces invalid dates with NULL.
- Recalculates sales:
    sales = quantity * price (if mismatch).
- Handles NULL and negative price values.
- Prevents division errors using NULLIF.

Source Table:
- bronze.crm_sales_details

Target Table:
- silver.crm_sales_details

===============================================================================
*/

USE DataWarehouse;

-- Load CRM Sales Details

INSERT INTO silver.crm_sales_details (
    sales_order_num,
    sales_product_key,
    sales_customer_id,
    sales_order_date,
    sales_ship_date,
    sales_due_date,
    sales_sales,
    sales_quantity,
    sales_price
)
SELECT
    sales_order_num,
    sales_product_key,
    sales_customer_id,

    -- Fix Invalid Dates
    CASE 
        WHEN sales_order_date = 0 OR LEN(sales_order_date) != 8 THEN NULL
        ELSE CAST(CAST(sales_order_date AS VARCHAR) AS DATE)
    END,

    CASE 
        WHEN sales_ship_date = 0 OR LEN(sales_ship_date) != 8 THEN NULL
        ELSE CAST(CAST(sales_ship_date AS VARCHAR) AS DATE)
    END,

    CASE 
        WHEN sales_due_date = 0 OR LEN(sales_due_date) != 8 THEN NULL
        ELSE CAST(CAST(sales_due_date AS VARCHAR) AS DATE)
    END,

    -- Fix Sales Value
    CASE 
        WHEN sales_sales IS NULL 
          OR sales_sales != sales_quantity * ABS(sales_price)
        THEN sales_quantity * ABS(sales_price)
        ELSE sales_sales
    END,

    sales_quantity,

    -- Fix Price
    CASE 
        WHEN sales_price IS NULL OR sales_price <= 0
        THEN sales_sales / NULLIF(sales_quantity, 0)
        ELSE sales_price
    END

FROM bronze.crm_sales_details;

---

SELECT * FROM silver.crm_sales_details;

