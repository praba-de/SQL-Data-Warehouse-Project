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
