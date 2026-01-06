# Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀  

This project demonstrates a **comprehensive end-to-end data warehousing and analytics solution**, covering the full journey from building a modern data warehouse to delivering actionable business insights.

Designed as a **hands-on portfolio project**, it highlights industry best practices in **data engineering and analytics**, including data modeling, data quality management, and SQL-based analytical reporting.

---
Designed as a hands-on portfolio project, it highlights industry best practices in data engineering and analytics, including data modeling, data quality management, and SQL-based analytical reporting.

This project focuses on analyzing sales performance and customer purchasing behavior to uncover actionable insights that drive revenue growth and optimize product strategy.  Using tools such as  SQL and Power BI, the project explores sales trends, customer segmentation, and product performance to identify opportunities for improvement.


## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using **SQL Server** to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (**ERP** and **CRM**) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.


## 📊 BI: Analytics & Reporting (Data Analytics)

### Objective
Develop SQL-based analytics to deliver detailed insights into:

- **Sales Trends**
- **Customer Behavior**
- **Product Performance**


These insights empower stakeholders with key business metrics, enabling data-driven and strategic decision-making.

## 🗄️ Data Warehouse Design
The data warehouse is designed using a dimensional (star schema) model optimized for analytical workloads.

## 🗄️ Data Warehouse Design

The data warehouse is designed using a **dimensional (star schema) model** optimized for analytical workloads.

### Fact Table
- **FactSales**
  - Sales Amount
  - Quantity Sold
  - Order Date
  - Customer Key
  - Product Key

### Dimension Tables
- **DimCustomer**
- **DimProduct**
- **DimDate**
- **DimLocation**

This design ensures high query performance and intuitive reporting.

---
## 🧪 Data Quality & Transformation

The following data processing steps are applied:
- Removal of duplicate records
- Standardization of data types
- Handling of missing or invalid values
- Enforcement of business rules
- Validation of referential integrity

  
### 🛠️ Tools & Technologies

- Database	SQL Server [Download here](https://www.microsoft.com/en-us/sql-server)

- Power BI [Download here](https://www.microsoft.com/en-us/power-platform/products/power-bi)

- Data Modeling	Star Schema

- Analytics	SQL Queries

- Version Control	Git & GitHub


### Key objectives include:

📊 Evaluating sales trends over time

🛒 Assessing product performance and profitability

💡 Providing recommendations for revenue optimization and product strategy

The outcomes of this project aim to help businesses make data-driven decisions, improve customer satisfaction, and maximize profitability.

 This Project has 6 dataset, 3 dataset come from crm system and other 3 come from erp system. All combain togher and form 3 dataset which are customer, Product and Sales.


## 🔹  Project Background 

Origin: Microsoft developed AdventureWorks as a sample database for SQL Server. It provides realistic business data for learning.

Fictional Company: Adventure Works Cycles is a multinational bicycle manufacturer that sells products such as road bikes, mountain bikes, and accessories.

Purpose: The database mimics a real company’s operations, including:

Sales transactions (orders, invoices, customers).

📌 Project Flow

Data understanding & schema design

Data Profiling, Remediation

Data cleaning using SQL

Exploratory data analysis (EDA)

KPI creation

Dashboard development and storytelling

Data Modeling 

Business insights & recommendations

## Data Stucture & Initial Checks
Database Stucture as seen below of 3 tables Product, Sales and Customer it showing Data Modeling. 
![Relationship](https://github.com/user-attachments/assets/0a931817-1742-4fa0-8f73-0befef1adf2f)

## 🔹 Executive Smmary

![visual](https://github.com/user-attachments/assets/d5ee0faf-01d0-428c-a2c7-1e06f5c39e10)


