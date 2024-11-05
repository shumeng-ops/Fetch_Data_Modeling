## Fetch Take Home Challenge Submission -- Shumeng Shi
<br>
This repository contains my submission for Fetch’s take-home challenge for the Analytics Engineer position. My goal for this project was to showcase my technical skills across various data engineering tools.😊 To demonstrate this, I built out the data model and warehouse directly in Snowflake and ran all queries within that environment. Below is a list of tools used to complete this project:<br><br>

- **AWS S3 Bucket**: Stored JSON files for receipts, users, and brands
- **Snowflake**: Used as the data warehouse
- **DBT**: Built the data models that populate the data warehouse<br><br>

📍📍 **Prerequisites: Setting Up Snowflake Environment and Loading Source Data from AWS S3**<br><br>

Before diving into the analysis, the initial setup involves creating a dedicated Snowflake warehouse, database, schema, role, and assigning necessary permissions for this project. After completing these steps, set up an external Snowflake stage pointing to the S3 bucket and load the three source JSON files from S3 into a Snowflake JSON table.

You can find the code for these steps [here](set_up_snowflake.sql).<br><br>

📍📍**First Section: Relational Data Model Diagram**<br><br>
I decided to expand the rewardsReceiptItemList array column into a separate table called receipts_item, where each row represents an individual item on a receipt. I created a surrogate key called receipts_items_key as the primary key. This structure not only makes it easier to join tables for insights but also improves datawarehouse scalability.

Several columns potentially serve as a key for joining receipts_item with the brands table, such as barcode, brandcode, and itemNumber. After reviewing these options and comparing their values, brandcode appears to provide the most consistent match between brands and receipt items. Based on this analysis, I decided to use brandcode as the key for connecting brands with receipts_item.

The code to create the staging tables from JSON format can be found in the staging folders; please refer to the link below.
- [users](models/staging/stg_users.sql)
- [brands](models/staging/stg_brands.sql)
- [receipts](models/staging/stg_receipts.sql)
- [receipts_items](models/staging/stg_receipts_items.sql)

Click [here](Fetch%20Data%20Model%20ERD.png) to view a larger version of the ERD.
![Fetch ERD](Fetch%20Data%20Model%20ERD.png)
<br><br>

📍📍**Second Section: Queries to answers predetermined questions**<br><br>
- What are the top 5 brands by receipts scanned for most recent month?
- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

To address the questions above, I created a data mart named [top5_brands_scanned_monthly](models/marts/top5_brands_scanned_monthly.sql) to monitor the top 5 brands according to the number of scanned receipts each month. This is a common use case, and by structuring it as a data mart, we ensure that the table can easily provide the top 5 brands for any chosen month.<br><br>