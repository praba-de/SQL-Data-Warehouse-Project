/*
=============================================================
Create Database and Schemas
=============================================================

Description:
    This script creates a database named 'DataWarehouse'.
    If the database already exists, it will be dropped and
    recreated. After creating the database, three schemas
    are created to support the Medallion Architecture:
    bronze, silver, and gold.

Schemas:
    bronze  - Stores raw data from source systems.
    silver  - Stores cleaned and transformed data.
    gold    - Stores curated data for analytics and reporting.

Warning:
    Executing this script will permanently delete the
    existing 'DataWarehouse' database if it exists.
    Ensure proper backups are available before running it.
*/

USE master;
GO

-- Drop database if it already exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    DROP DATABASE DataWarehouse;
END
GO

-- Create database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the new database
USE DataWarehouse;
GO

-- Create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
