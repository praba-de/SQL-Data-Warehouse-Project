/*
Stored Procedure: Load Silver Layer (Bronze → Silver)

Description:
This stored procedure performs the ETL (Extract, Transform, Load) process
to populate the tables in the 'silver' schema using data from the 'bronze'
schema.

Process Overview:
The procedure performs the following steps:
1. Truncates existing data in the Silver tables.
2. Extracts raw data from the Bronze layer.
3. Cleans and transforms the data.
4. Loads the transformed data into the Silver tables.

Key Transformations:
- Removes duplicate records.
- Standardizes categorical values (e.g., gender, marital status).
- Trims unnecessary whitespace.
- Handles NULL values.
- Applies business logic for data consistency.

Parameters:
None.
This stored procedure does not accept any input parameters.

Return Value:
None.
The procedure loads data into Silver tables but does not return a result set.

Usage Example:
EXEC silver.load_silver;

===============================================================================
*/
