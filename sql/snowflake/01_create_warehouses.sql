-- Project: Flights data engineering platform
-- File: 01_create_warehouses.sql
-- Purpose: Create compute warehouses for the project

USE ROLE SYSADMIN;

-- Warehouse: LOAD_WH
-- purpose: Data Ingestion (Fivetran)

CREATE WAREHOUSE IF NOT EXISTS LOAD_WH
WITH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = ' Warehouse used for data ingestion workloads';

-- Warehouse: TRANSFORM_WH
-- purpose: dbt transformations

CREATE WAREHOUSE IF NOT EXISTS TRANSFORM_WH
WITH
    WAREHOUSE_SIZE = 'SMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Warehouse used for dbt transformations';

-- Warehouse: BI_WH
-- purpose: Tableau reporting and ad-hoc analytics

CREATE WAREHOUSE IF NOT EXISTS BI_WH
WITH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Warehouse used for BI reporting and dashbaords';
