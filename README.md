# 🚀 End-to-End Sales Data Pipeline
A production-style ETL pipeline built with Python, pandas, SQLAlchemy, and MySQL —
designed to ingest raw sales data, clean it, load it into a relational database,
and generate business insights using advanced SQL.
---
## 📌 Project Overview
This project simulates a real-world data engineering workflow:
- **Extract** raw CSV sales data using Python and pandas
- **Transform** the data — handle missing values, fix date formats, add calculated columns, validate quality
- **Load** clean data into a MySQL database using SQLAlchemy
- **Analyse** using advanced SQL — CTEs, window functions, ranking, and month-over-month growth
---
## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| Python 3 | Core programming language |
| pandas | Data extraction and transformation |
| SQLAlchemy | Python-to-MySQL connection |
| pymysql | MySQL driver |
| MySQL | Relational database and SQL analytics |
| Jupyter Notebook | Development environment (Anaconda) |
| schedule | Automated daily pipeline scheduling |
---
## 📊 Dataset
- **60 rows** of sales transactions across 5 months (Jan–May 2024)
- **9 columns:** order_id, order_date, customer_name, product, category, quantity, unit_price, region, salesperson
- **Intentional data quality issues:** missing customer names, missing quantities, invalid date formats
---
## 🔧 ETL Pipeline Steps
### 1. Extract
- Read raw `sales.csv` into a pandas DataFrame
- Inspect shape, data types, and missing values
### 2. Transform
- Drop rows with missing `customer_name`
- Fill missing `quantity` with default value of 1
- Parse and validate `order_date` — coerce invalid dates to NaT and drop
- Calculate `revenue = quantity × unit_price`
- Extract `order_month` for monthly reporting
- Standardise text columns — strip whitespace, title case
- Assert data quality checks before loading
### 3. Load
- Connect to MySQL using SQLAlchemy connection string
- Load clean DataFrame into `sales` table using `df.to_sql()`
- Verify row count after load
---
## 📈 Business Insights (SQL)
All queries are in `reports/insights.sql`. Key findings from the dataset:
| Insight | Result |
|---|---|
| Top region by revenue | West |
| Top customer by spend | Deepak Shah |
| Best growth month | February 2024 (+40.26%) |
| Top salesperson | Amit |
### SQL techniques used:
- **CTEs** (`WITH` clause) for readable multi-step queries
- **Window functions** — `RANK()`, `ROW_NUMBER()`, `LAG()`
- **PARTITION BY** for per-region and per-salesperson analysis
- **Month-over-month growth** calculation using `LAG()`
---
## 🎯 Skills Demonstrated
- ETL pipeline design and implementation
- Data cleaning and validation with pandas
- Relational database loading with SQLAlchemy
- Advanced SQL — window functions, CTEs, aggregations
- Pipeline automation and scheduling
- Python modular code structure
---
