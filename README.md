# 🛒 E-Commerce SQL Analysis

Exploratory data analysis on a real-world e-commerce dataset using **SQL** and **DuckDB / DataCamp DataLab**.  
This project answers key business questions around revenue, customer behavior, product performance, and data quality.

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![DuckDB](https://img.shields.io/badge/Tool-DuckDB-yellow)
![DataLab](https://img.shields.io/badge/Platform-DataCamp%20DataLab-03EF62)
![Status](https://img.shields.io/badge/Status-In%20Progress-orange)

---

## 📁 Project Structure

```
E-Commerce-SQL-Analysis/
├── data/
│   └── online_retail.csv        ← download from UCI link below
├── analysis.sql
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

> **To use locally:** Download `Online Retail.xlsx` from the UCI link above, convert to CSV, and save as `data/online_retail.csv`

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
| 01 | Explore the data | Preview first 10 rows |
| 02 | Total row count | Data quality check |
| 03 | Missing CustomerIDs | Count null customer records |
| 04 | Clean dataset | Filter nulls + parse timestamps |
| 05 | Sales by country | Total revenue grouped by country |
| 06 | Top customers | Ranked by total spend |
| 07 | Best-selling products | Top 10 by quantity sold |
| 08 | Missing data by country | Null CustomerID rate per country |
| 09 | Monthly revenue trend | Month-over-month sales |
| 10 | Average order value | By country |

---

## 💡 Key Insights

- **United Kingdom** generates the majority of total sales
- A notable percentage of rows have **missing CustomerIDs**, limiting customer-level analysis
- A **small number of customers** drive a disproportionately large share of revenue
- Revenue shows clear **seasonal trends** across the year

---

## 🚀 How to Run

**Option 1 — DataCamp DataLab**
1. Open [DataCamp DataLab](https://www.datacamp.com/datalab)
2. Add **E-Commerce Data** as a data source
3. Paste queries from `analysis.sql` into a SQL cell and run

**Option 2 — DuckDB CLI**
```bash
# Install DuckDB
pip install duckdb

# Launch CLI and run the full script
duckdb
.read analysis.sql
```

**Option 3 — Python**
```python
import duckdb

conn = duckdb.connect()
with open('analysis.sql') as f:
    queries = f.read()

conn.execute(queries)
```

---

## 🛠 Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL | Data querying and analysis |
| DuckDB | In-process analytical SQL engine |
| DataCamp DataLab | Cloud notebook environment |
| GitHub | Version control and portfolio |

---

## 👤 Author

**swezinye**  
[GitHub Profile](https://github.com/swezinye)
