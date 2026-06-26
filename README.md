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
Database Stucture it showing Data Modeling . 
<img width="1237" height="513" alt="image" src="https://github.com/user-attachments/assets/316db566-312c-4629-a774-d46d6fee8c4d" />





## 🔹 Executive Smmary

<img width="933" height="495" alt="image" src="https://github.com/user-attachments/assets/3418a7c3-66e7-4e0c-b864-f9bd828bd950" />



## 🔹 Sales Performance Analysis Insight (2010–2014)

The dashboard provides an overview of sales performance by revenue, quantity sold, orders, and customers.

**1. Overall Business Performance**

* **Total Revenue:** **29M**
* **Total Quantity Sold:** **60K units**
* **Total Orders:** **28K**
* **Total Customers:** **18K**

**2. Revenue Trend Analysis**
The sales trend between **2010–2014** shows significant fluctuations:

* **2010:** Revenue started very low (**0.0M**), indicating that business launch phase a operational performance.
* **2011:** Revenue increased sharply to **7.1M**, showing strong business growth.
* **2012:** Revenue slightly declined to **5.8M**, which may indicate reduced sales activity, lower demand, or operational challenges.
* **2013:** Revenue peaked at **16.3M**, representing the highest-performing year and major growth opportunity.
* **2014:** Revenue dropped significantly (**0.0M**), which may suggest incomplete data, operational interruption, or a decline requiring further investigation.

**Key Insight:**
The company experienced its **best performance in 2013**, contributing the highest share of total revenue. However, the inconsistency in yearly performance suggests a need to investigate drivers behind both growth periods and declines.

**3. Product Quantity Performance**
The top-selling products are primarily from the **Mountain-200 bike category**, with quantities ranging approximately **580–620 units**.

Top-performing products include:

* Mountain-200 Black
* Mountain-200 Silver

**Business Insight:**
The **Mountain-200 series** appears to be the strongest-performing product line and may be a key revenue driver. :

* Increase focus on inventory availability for these products.
* Improve promotions around high-demand models.
* Analyze customer preferences to understand why these variants outperform others.

**4. Customer and Order Insight**
With **28K orders** generated from **18K customers**, this suggests:

* Many customers made repeat purchases.
* Customer retention may be relatively healthy.

**Recommendations**

1. **Investigate the revenue drop after 2013** to identify causes (market changes, or operational factors).
2. **Focus on high-performing products** (Mountain-200 category) to maximize sales.
3. **Improve sales consistency** by analyzing what contributed to the strong 2013 performance and replicating those strategies.
4. **Leverage customer data** to improve retention and upselling opportunities.




