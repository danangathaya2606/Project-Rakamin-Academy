# Data Analysis: Kimia Farma Sales Performance (Big Data)
## Project Overview

This project focuses on analyzing the sales data and operational performance of Kimia Farma, a leading pharmaceutical company in Indonesia. Using SQL (BigQuery), I integrated multiple datasets—including sales transactions, inventory, and branch locations—to create a unified table for business intelligence reporting. The primary goal was to calculate key performance indicators (KPIs) like profit margins, branch ratings, and sales trends to support data-driven decision-making.

## Data Schema
The analysis involves four main tables:
1. kf_final_transaction -> Containing all sales transaction records.
- transaction_id: Unique identifier for each transaction (String).
- date: The date when the transaction occurred (Date).
- branch_id: Foreign key identifying the branch where the sale took place (Integer).
- customer_name: Name of the customer (String).
- product_id: Foreign key identifying the specific product sold (String).
- price: Unit price of the product (Integer).
- discount_percentage: The discount rate applied to the transaction (Float).
- rating: Customer satisfaction rating for the individual transaction (Float).

2. kf_inventory -> Providing insights into product stock levels across different branches.
- Inventory_ID: Unique identifier for the inventory record (String).
- branch_id: Foreign key linked to the branch location (Integer).
- product_id: Foreign key identifying the specific product sold (String).
- product_name: The official name of the product (String).
- opname_stock: The physical stock count available at the location (Integer).

3. kf_kantor_cabang -> Table containing data for Kimia Farma’s branch information.
- branch_id: Primary key for the branch (Integer).
- branch_category: The type of branch (String).
- branch_name: The specific name of the branch (String).
- kota: The city where the branch is located (String).
- provinsi: The province where the branch is located (String).
- rating: The overall average customer rating for the branch (Float).

4. kf_product -> Table containing information about the product
- product_id: Foreign key identifying the specific product sold (String).
- product_name: The official name of the product (String).
- product_category: category classification of each product (String).

## Key Metrics and Business Logic
In this project, I implementend some additional calculated field to derive deeper insights.

1. Gross Profit Margin: Calculated based on the price tiering:
   - Price $\le$ 50k: 10% margin
   - 50k < Price $\le$ 100k: 15% margin
   - 100k < Price $\le$ 300k: 20% margin
   - 300k < Price $\le$ 500k: 25% margin
   - Price > 500k: 30% margin
2. Nett Profit: Price x (1 - Discount Percentage)
3. Nett Sales: Price x Gross Profit Margin
