--- Create warehouse, database, role

USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS fetch_wh WITH warehouse_size = 'x-small';
CREATE DATABASE fetch_db;
CREATE ROLE fetch_role;
CREATE SCHEMA fetch_db.fetch_schema;

CREATE STORAGE INTEGRATION s3_int
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::891377267450:role/snowflake_s3_role'
  STORAGE_ALLOWED_LOCATIONS = ('*');

-- DESC INTEGRATION s3_int;

-- grant necessary access
grant usage on warehouse fetch_wh to role fetch_role;
grant role fetch_role to user shumengshi;
grant all on database fetch_db to role fetch_role;

GRANT CREATE STAGE ON SCHEMA fetch_schema TO ROLE fetch_role;
GRANT USAGE ON INTEGRATION s3_int TO ROLE fetch_role;


-- Copy three json files from S3 to Snowflake
USE SCHEMA fetch_db.fetch_schema;

CREATE STAGE fetch_s3_stage
  STORAGE_INTEGRATION = s3_int
  URL = 's3://fetch-takehome-challenge'

-- Receipts
CREATE TABLE receipts_json(json_data variant);
COPY INTO receipts_json
FROM @fetch_s3_stage/receipts.json
FILE_FORMAT = (TYPE = 'JSON');

-- Users
CREATE TABLE users_json(json_data variant);
COPY INTO users_json
FROM @fetch_s3_stage/users.json
FILE_FORMAT = (TYPE = 'JSON');

-- brands
CREATE TABLE brands_json(json_data variant);
COPY INTO brands_json
FROM @fetch_s3_stage/brands.json
FILE_FORMAT = (TYPE = 'JSON');

