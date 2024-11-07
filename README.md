## Fetch Take Home Challenge Submission -- Shumeng Shi
<br>
This repository contains my submission for Fetch’s take-home challenge for the Analytics Engineer position. My goal for this project was to showcase my technical skills across various data engineering tools.😊 To demonstrate this, I built out the data model and warehouse directly in Snowflake and ran all queries within that environment. Below is a list of tools used to complete this project:<br><br>

- **AWS S3 Bucket**: Stored JSON files for receipts, users, and brands
- **Snowflake**: Used as the data warehouse
- **DBT**: Built the data models that populate the data warehouse
- **Python**: Evaluate Data Quality Issue 
<br><br>

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

📍📍**Third Section: Data Quality Evaluation**<br><br>
You can find the Jupyter notebook [here](Fetch_Data_Quality_Checks.ipynb), which includes code and functions to identify data issues and a summary of findings across all three tables. In this step, I created two reusable functions to calculate the percentage of unique values and null values for any given DataFrame and columns. I also checked for inconsistencies within tables, such as cases where the purchased item count is greater than 0, but the item list is null.<br><br>

📍📍**Fourth Section: Communication with Stakeholders**<br><br>

**Subject: Quick Check-In on Some Data Findings**

Hi [Stakeholder’s Name],

I hope you’re doing well! I’m Shumeng, the analytics engineer on the [Team Name] team. As I reviewed some of our datasets, I noticed a few patterns that raised some questions, and I wanted to reach out for your insights.

While there are a few potential data quality issues—like duplicated User IDs, which I’ll be discussing with our engineering team—there are also a few areas where I think business context could help clarify what I’m seeing. If you have a moment, I’d love to connect and get your perspective.

1. When users first sign up with Fetch, is “State” a required field? I’m noticing quite a few records where the State field is blank, and I’m wondering if this field might be optional during sign-up
2. What are the available sign-up sources for Fetch users? I currently see “Email,” “Google,” and some null values, so I’m wondering if the nulls might represent another sign-up method.
3. For our brand records, what serves as the unique identifier? Is it the barcode or the brand code? Currently, neither appears to be unique for each brand ID. Additionally, there are many items in the receipts table with barcodes or brand codes that don’t exist in our brand table. This lack of completeness in our brand data could create challenges in data analysis.
4. What does the CPG_ID and CPG_REF of a brand refers to in the business world?
5. What are the rules for rewarding points for scanned receipts? I noticed that some receipts marked as “rejected” still show points awarded. Is that expected?
6. Could you please explain the different stages of a receipt? I see stages like “submitted,” “pending,” “finished,” “flagged,” and “rejected.” Specifically, what does “finished” mean, and what’s the difference between “submitted” and “pending”?