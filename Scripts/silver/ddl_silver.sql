CREATE TABLE silver.crm_customer_info (
    customer_id             INT,
    customer_key            NVARCHAR(50),
    customer_firstname      NVARCHAR(50),
    customer_lastname       NVARCHAR(50),
    customer_marital_status NVARCHAR(50),
    customer_gndr           NVARCHAR(50),
    customer_create_date    DATE,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.crm_product_info (
    product_id              INT,
    category_id             NVARCHAR(50),
    product_key             NVARCHAR(50),
    product_name            NVARCHAR(50),
    product_cost            INT,
    product_line            NVARCHAR(50),
    product_start_date      DATE,
    product_end_date        DATE,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.crm_sales_details (
    sales_order_num         NVARCHAR(50),
    sales_product_key       NVARCHAR(50),
    sales_customer_id       INT,
    sales_order_date        DATE,
    sales_ship_date         DATE,
    sales_due_date          DATE,
    sales_sales             INT,
    sales_quantity          INT,
    sales_price             INT,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_customer (
    cid                     NVARCHAR(50),
    birth_date              DATE,
    gender                  NVARCHAR(50),
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_location (
    cid                     NVARCHAR(50),
    country                 NVARCHAR(50),
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE silver.erp_product_category (
    id                      NVARCHAR(50),
    category                NVARCHAR(50),
    sub_cat                 NVARCHAR(50),
    maintenance             NVARCHAR(50),
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
