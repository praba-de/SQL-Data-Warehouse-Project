/*
===============================================================================
Stored Procedure: Load CRM Customer Info (Bronze → Silver)
===============================================================================

Description:
This procedure loads and transforms customer data from the Bronze layer 
into the Silver layer.

Process Overview:
1. Extracts data from bronze.crm_customer_info.
2. Removes duplicate records using ROW_NUMBER().
3. Cleans and trims text fields.
4. Standardizes marital status and gender values.
5. Converts date fields into proper DATE format.
6. Loads the cleaned data into silver.crm_customer_info.

Key Transformations:
- Removes duplicate customer records (keeps latest entry).
- Trims first and last names.
- Standardizes:
    * Marital Status → Single / Married / N/A
    * Gender → Male / Female / N/A
- Converts customer_create_date to DATE.

Source Table:
- bronze.crm_customer_info

Target Table:
- silver.crm_customer_info

===============================================================================
*/

USE DataWarehouse;

-- Load CRM Customer Info (Bronze → Silver)

INSERT INTO silver.crm_customer_info (
    customer_id,
    customer_key,
    customer_firstname,
    customer_lastname,
    customer_marital_status,
    customer_gender,
    customer_create_date
)
SELECT 
    customer_id,
    customer_key,
    TRIM(customer_firstname) AS customer_firstname,
    TRIM(customer_lastname) AS customer_lastname,
    
    -- Standardize Marital Status
    CASE 
        WHEN UPPER(TRIM(customer_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(customer_marital_status)) = 'M' THEN 'Married'
        ELSE 'N/A'
    END AS customer_marital_status,

    -- Standardize Gender
    CASE 
        WHEN UPPER(TRIM(customer_gender)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(customer_gender)) = 'M' THEN 'Male'
        ELSE 'N/A'
    END AS customer_gender,

    TRY_CONVERT(DATE, customer_create_date) AS customer_create_date

FROM (
    -- Remove duplicates (latest record)
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY customer_create_date DESC
        ) AS flag_last
    FROM bronze.crm_customer_info
    WHERE customer_id IS NOT NULL
) t
WHERE flag_last = 1;
---

select * from silver.crm_customer_info;
