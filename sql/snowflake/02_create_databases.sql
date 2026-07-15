-- Project: Flights Data Engineering Platform
-- File: 02_create_databases.sql
-- Purpose: Create project databases

USE ROLE SYSADMIN;

-- Raw ingestion database

CREATE DATABASE IF NOT EXISTS FLIGHTS_RAW
COMMENT = 'Raw ingestion database populated by Fivetran';

-- Analytics database

CREATE DATABASE IF NOT EXISTS FLIGHTS_ANALYTICS
COMMENT = 'Analytics database containing dbt models and reporting objects';