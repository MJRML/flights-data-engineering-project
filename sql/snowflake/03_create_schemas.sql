-- Project: Flights Data Engineering Platform
-- File: 03_create_schemas.sql
-- Purpose: Create schemas for the analytics platform

USE ROLE SYSADMIN;

-- Raw schema

CREATE SCHEMA IF NOT EXISTS FLIGHTS_RAW.RAW
COMMENT = 'Raw data loaded by Fivetran, no transformations';

-- Analytics Schema

CREATE SCHEMA IF NOT EXISTS FLIGHTS_ANALYTICS.STAGING
COMMENT = 'Initial cleaning and standardization of source data';

CREATE SCHEMA IF NOT EXISTS FLIGHTS_ANALYTICS.INTERMEDIATE
COMMENT = 'Reusable business transformations and logic';

CREATE SCHEMA IF NOT EXISTS FLIGHTS_ANALYTICS.MARTS
COMMENT = 'Fact and dimension tables for analytics';

CREATE SCHEMA IF NOT EXISTS FLIGHTS_ANALYTICS.SEMANTIC
COMMENT = 'business logic models and views for BI tools';