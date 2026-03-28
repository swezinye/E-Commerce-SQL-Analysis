# 🛒 E-Commerce SQL Analysis

Exploratory data analysis on a real-world e-commerce dataset using **SQL** and **DataCamp DataLab**.  
This project answers key business questions around revenue, customer behavior, product performance, and data quality.

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![DuckDB](https://img.shields.io/badge/Tool-DuckDB-yellow)
![DataLab](https://img.shields.io/badge/Platform-DataCamp%20DataLab-03EF62)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

---

## 📁 Project Structure

```
E-Commerce-SQL-Analysis/
├── analysis.sql       ← all 10 SQL queries
└── README.md
```

---

## 📊 Dataset

**Source:** [UCI Machine Learning Repository — Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)

Transnational transaction data from a UK-based online retailer (December 2010 – December 2011).  
~541,000 rows · 8 columns

| Column | Description |
|---|---|
| InvoiceNo | Invoice number (prefix `C` = cancellation) |
| StockCode | Product code |
| Description | Product name |
| Quantity | Units per transaction |
| InvoiceDate | Date and time of invoice |
| UnitPrice | Price per unit (GBP £) |
| CustomerID | Unique customer identifier *(nullable)* |
| Country | Country of customer residence |

---

## ❓ Key Questions

- Which countries generate the most revenue?
- Who are the top customers?
- What products sell the most?
- How much customer data is missing?
- How does revenue trend month over month?

---

## 🔍 SQL Queries Overview

| # | Query | Description |
|---|---|---|
| 01 | Explore the data | Preview first 10 rows of the dataset |
| 02 | Total row count | Verify total number of records |
| 03 | Missing CustomerIDs | Count rows with no customer identifier |
| 04 | Clean dataset | Filter nulls and invalid transactions |
| 05 | Sales by country | Total revenue grouped by country |
| 06 | Top customers | Top 10 customers ranked by total spend |
| 07 | Best-selling products | Top 10 products by quantity sold |
| 08 | Missing data by country | Null CustomerID rate per country |
| 09 | Monthly revenue trend | Month-over-month revenue and order count |
| 10 | Average order value | Average spend per order by country |

---

## 💡 Key Insights

- **United Kingdom** dominates total sales, contributing the vast majority of revenue
- A **small number of customers** drive a disproportionately large share of total spend
- A significant percentage of transactions have **missing CustomerIDs**, particularly from certain countries, which limits customer-level analysis
- Revenue shows a clear **upward trend toward Q4**, reflecting seasonal demand peaks
- The **top 10 best-selling products** are predominantly gift and home décor items

---

## ⚙️ Technical Notes

All queries are written in **DuckDB SQL** and run on DataCamp DataLab.  
Dates in the CSV follow the format `MM/DD/YY HH:MM` — parsed using:

```sql
FROM read_csv('online_retail.csv',
    header          = true,
    timestampformat = '%m/%d/%y %H:%M'
)
```

Data cleaning applied across all analysis queries:
- Removed rows where `CustomerID IS NULL`
- Excluded rows where `Quantity <= 0` (returns/cancellations)
- Excluded rows where `UnitPrice <= 0` (invalid pricing)

---

## 🚀 How to Run

**DataCamp DataLab**
1. Open [DataCamp DataLab](https://www.datacamp.com/datalab)
2. Add **E-Commerce Data** as a data source
3. Copy queries from `analysis.sql` into a SQL cell and run

**DuckDB CLI**
```bash
pip install duckdb
duckdb
.read analysis.sql
```

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL | Data querying and analysis |
| DuckDB | In-process analytical SQL engine |
| DataCamp DataLab | Cloud SQL notebook environment |
| GitHub | Version control and portfolio hosting |

---

## 👤 Author

**swezinye**  
[GitHub Profile](https://github.com/swezinye)
