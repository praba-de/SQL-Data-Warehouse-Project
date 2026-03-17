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
