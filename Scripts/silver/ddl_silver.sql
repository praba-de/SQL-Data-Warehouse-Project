USE DataWarehouse;
GO
    
/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema of the data warehouse.

    The Silver layer represents cleaned and standardized data transformed
    from the Bronze layer as part of the Medallion Architecture
    (Bronze → Silver → Gold).

Usage:
    This script drops existing Silver tables (if they exist) and recreates them.
===============================================================================
*/

---------------------------------------------------------
-- CRM CUSTOMER INFO
---------------------------------------------------------
IF OBJECT_ID('silver.crm_customer_info', 'U') IS NOT NULL
DROP TABLE silver.crm_customer_info;

CREATE TABLE silver.crm_customer_info (
    customer_id             INT,
    customer_key            NVARCHAR(50),
    customer_firstname      NVARCHAR(50),
    customer_lastname       NVARCHAR(50),
    customer_marital_status NVARCHAR(50),
    customer_gndr           NVARCHAR(50),
    customer_create_date    DATE
);

---------------------------------------------------------
-- CRM PRODUCT INFO
---------------------------------------------------------
IF OBJECT_ID('silver.crm_product_info', 'U') IS NOT NULL
DROP TABLE silver.crm_product_info;

CREATE TABLE silver.crm_product_info (
    product_id              INT,
    product_key             NVARCHAR(50),
    product_name            NVARCHAR(50),
    product_cost            INT,
    product_line            NVARCHAR(50),
    product_start_date      DATE,
    product_end_date        DATE
);

---------------------------------------------------------
-- CRM SALES DETAILS
---------------------------------------------------------
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
    sales_order_num         NVARCHAR(50),
    sales_product_key       NVARCHAR(50),
    sales_customer_id       INT,
    sales_order_date        DATE,
    sales_ship_date         DATE,
    sales_due_date          DATE,
    sales_sales             INT,
    sales_quantity          INT,
    sales_price             INT
);

---------------------------------------------------------
-- ERP CUSTOMER
---------------------------------------------------------
IF OBJECT_ID('silver.erp_customer', 'U') IS NOT NULL
DROP TABLE silver.erp_customer;

CREATE TABLE silver.erp_customer (
    cid                     NVARCHAR(50),
    birth_date              DATE,
    gender                  NVARCHAR(50)
);

---------------------------------------------------------
-- ERP LOCATION
---------------------------------------------------------
IF OBJECT_ID('silver.erp_location', 'U') IS NOT NULL
DROP TABLE silver.erp_location;

CREATE TABLE silver.erp_location (
    cid                     NVARCHAR(50),
    country                 NVARCHAR(50)
);

---------------------------------------------------------
-- ERP PRODUCT CATEGORY
---------------------------------------------------------
IF OBJECT_ID('silver.erp_product_category', 'U') IS NOT NULL
DROP TABLE silver.erp_product_category;

CREATE TABLE silver.erp_product_category (
    id                      NVARCHAR(50),
    category                NVARCHAR(50),
    sub_cat                 NVARCHAR(50),
    maintenance             NVARCHAR(50)
);
