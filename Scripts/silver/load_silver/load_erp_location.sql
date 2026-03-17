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
