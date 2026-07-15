-- Project: Flights Data Engineering Platform
-- File: 04_create_roles.sql
-- Purpose: Create custom project roles

USE ROLE SECURITYADMIN;

-- ---------------------
-- Project administrator
-- ---------------------

CREATE ROLE IF NOT EXISTS FLIGHTS_ADMIN
COMMENT = 'Administrator role for the Flights Data Engineering project';

CREATE ROLE IF NOT EXISTS DATA_ENGINEER_ROLE
COMMENT = 'Role used by data engineer for daya to day project work';

-- -----------------
-- Application roles
-- -----------------

CREATE ROLE IF NOT EXISTS FIVETRAN_ROLE
COMMENT = 'Role used by Fivetran to ingest raw data';

CREATE ROLE IF NOT EXISTS DBT_ROLE
COMMENT = 'Role used by dbt cloud for data transformations';

CREATE ROLE IF NOT EXISTS BI_ROLE
COMMENT = 'Read-only role used by BI tools';