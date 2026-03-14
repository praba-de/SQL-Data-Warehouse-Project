/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates staging tables in the 'bronze' schema of the 
    DataWarehouse database.

    The Bronze layer stores raw ingested data from source systems
    such as CRM and ERP. Data is loaded exactly as received from
    the source files with minimal transformation.

    These tables act as the landing zone before data cleansing
    and transformation into the Silver layer.

Key Features:
    • Raw data ingestion
    • Minimal transformation
    • Supports Medallion Architecture (Bronze → Silver → Gold)
    • Includes metadata column for load tracking

Usage:
    Run this script to drop and recreate Bronze tables.
===============================================================================
*/

USE DataWarehouse;
GO

-- =====================================================
-- CRM TABLES
-- =====================================================

-- -----------------------------------
-- CRM Customer Information
-- -----------------------------------
IF OBJECT_ID('bronze.crm_customer_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_customer_info;
GO

CREATE TABLE bronze.crm_customer_info (
    customer_id              INT,
    customer_key             NVARCHAR(50),
    customer_firstname       NVARCHAR(50),
    customer_lastname        NVARCHAR(50),
    customer_marital_status  NVARCHAR(50),
    customer_gender          NVARCHAR(50),
    customer_create_date     VARCHAR(50),
    dwh_load_date            DATETIME2 DEFAULT GETDATE()
);
GO


-- -----------------------------------
-- CRM Product Information
-- -----------------------------------
IF OBJECT_ID('bronze.crm_product_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_product_info;
GO

CREATE TABLE bronze.crm_product_info (
    product_id          INT,
    product_key         NVARCHAR(50),
    product_name        NVARCHAR(50),
    product_cost        INT,
    product_line        NVARCHAR(50),
    product_start_date  NVARCHAR(50),
    product_end_date    NVARCHAR(50),
    dwh_load_date       DATETIME2 DEFAULT GETDATE()
);
GO


-- -----------------------------------
-- CRM Sales Details
-- -----------------------------------
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sales_order_num     NVARCHAR(50),
    sales_product_key   NVARCHAR(50),
    sales_customer_id   INT,
    sales_order_date    INT,
    sales_ship_date     INT,
    sales_due_date      INT,
    sales_sales         INT,
    sales_quantity      INT,
    sales_price         INT,
    dwh_load_date       DATETIME2 DEFAULT GETDATE()
);
GO


-- =====================================================
-- ERP TABLES
-- =====================================================

-- -----------------------------------
-- ERP Location
-- -----------------------------------
IF OBJECT_ID('bronze.erp_location', 'U') IS NOT NULL
    DROP TABLE bronze.erp_location;
GO

CREATE TABLE bronze.erp_location (
    cid             NVARCHAR(50),
    country         NVARCHAR(50),
    dwh_load_date   DATETIME2 DEFAULT GETDATE()
);
GO


-- -----------------------------------
-- ERP Customer
-- -----------------------------------
IF OBJECT_ID('bronze.erp_customer', 'U') IS NOT NULL
    DROP TABLE bronze.erp_customer;
GO

CREATE TABLE bronze.erp_customer (
    cid             NVARCHAR(50),
    birth_date      DATE,
    gender          NVARCHAR(50),
    dwh_load_date   DATETIME2 DEFAULT GETDATE()
);
GO


-- -----------------------------------
-- ERP Product Category
-- -----------------------------------
IF OBJECT_ID('bronze.erp_product_category', 'U') IS NOT NULL
    DROP TABLE bronze.erp_product_category;
GO

CREATE TABLE bronze.erp_product_category (
    id              NVARCHAR(50),
    category        NVARCHAR(50),
    sub_cat         NVARCHAR(50),
    maintenance     NVARCHAR(50),
    dwh_load_date   DATETIME2 DEFAULT GETDATE()
);
GO
