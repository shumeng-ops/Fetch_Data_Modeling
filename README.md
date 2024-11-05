## Fetch Take Home Challenge Submission -- Shumeng Shi

This repository contains my submission for Fetch’s take-home challenge for the Analytics Engineer position. My goal for this project was to showcase my technical skills across various data engineering tools. To demonstrate this, I built out the data model and warehouse directly in Snowflake and ran all queries within that environment. Below is a list of tools used to complete this project:

- **AWS S3 Bucket**: Stored JSON files for receipts, users, and brands
- **Snowflake**: Used as the data warehouse
- **DBT**: Built the data models that populate the data warehouse

### Prerequisites: Setting Up Snowflake Environment and Loading Source Data from AWS S3




Before diving into the analysis, the initial setup involves creating a dedicated Snowflake warehouse, database, schema, role, and assigning necessary permissions for this project. After completing these steps, set up an external Snowflake stage pointing to the S3 bucket and load the three source JSON files from S3 into a Snowflake JSON table.

You can find the code for these steps [here](set_up_snowflake.sql).