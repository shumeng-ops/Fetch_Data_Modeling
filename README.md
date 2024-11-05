## Fetch Take Home Challenge Submission -- Shumeng Shi
<br>
This repository contains my submission for Fetch’s take-home challenge for the Analytics Engineer position. My goal for this project was to showcase my technical skills across various data engineering tools.😊 To demonstrate this, I built out the data model and warehouse directly in Snowflake and ran all queries within that environment. Below is a list of tools used to complete this project:<br><br>

- **AWS S3 Bucket**: Stored JSON files for receipts, users, and brands
- **Snowflake**: Used as the data warehouse
- **DBT**: Built the data models that populate the data warehouse<br><br>

📍📍 **Prerequisites: Setting Up Snowflake Environment and Loading Source Data from AWS S3**<br><br>

Before diving into the analysis, the initial setup involves creating a dedicated Snowflake warehouse, database, schema, role, and assigning necessary permissions for this project. After completing these steps, set up an external Snowflake stage pointing to the S3 bucket and load the three source JSON files from S3 into a Snowflake JSON table.

You can find the code for these steps [here](set_up_snowflake.sql).

📍📍**First Section: Relational Data Model Diagram**<br><br>
I decided to expand the rewardsReceiptItemList array column into a separate table called receipts_item, where each row represents an individual item on a receipt. I created a surrogate key called receipts_items_key as the primary key. By creating a dedicated table, I can better capture valuable details about each item, such as price, points, user flags, and review status. This structure not only makes it easier to join tables for insights but also improves datawarehouse scalability.

There isn’t a straightforward foreign key for linking brands to each item in receipts_item. Several columns could potentially serve as a key for joining with the brands table, such as barcode, brandcode, and itemNumber. After reviewing these options and comparing their values, brandcode appears to provide the most consistent match between brands and receipt items. Based on this analysis, I decided to use brandcode as the key for connecting brands with receipts_item.