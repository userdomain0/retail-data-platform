# 📊 Retail Sales Intelligence Platform

## 📌 Project Overview
This project builds a retail data platform to analyze grocery store sales data and generate actionable business insights.

It simulates a real-world data workflow from raw data ingestion to analytics and dashboard visualization.

The goal is to demonstrate both **data engineering** and **business intelligence** capabilities.

---

## 🎯 Business Objectives
- Analyze sales trends across time
- Identify top-performing products
- Compare store performance by region
- Detect abnormal sales patterns

---

## 🛠 Tech Stack
- Python (Pandas)
- Microsoft SQL Server (MSSQL)
- SQL (T-SQL)
- Tableau
- GitHub

---

## 🏗 Data Architecture

Kaggle Dataset  
↓  
Python ETL Pipeline  
↓  
MSSQL Database (Data Warehouse)  
↓  
SQL Analytics  
↓  
Tableau Dashboard  

---

## 🔄 Data Pipeline

### Extract
- Load raw CSV data from Kaggle dataset

### Transform
- Clean and preprocess data using Python (Pandas)
- Handle missing values and data formatting

### Load
- Insert structured data into MSSQL database
- Design relational tables for analytics

---

## 🧠 Data Modeling
The data warehouse includes:

- `sales` (transaction data)
- `products`
- `stores`

Designed to support efficient analytical queries.

---

## 📊 Key Analysis

- Sales trend over time
- Top-selling products ranking
- Store-level performance comparison
- (Planned) anomaly detection

---

## 📂 Project Structure

retail-data-platform/  
│  
├── config/  
├── data/  
├── etl/  
├── sql/  
├── dashboard/  
├── doc/  
└── README.md  

---

## 🚀 Future Improvements
- Automate ETL with scheduling
- Optimize SQL query performance
- Add anomaly detection logic
- Migrate to cloud data warehouse (future scalability)

---

## 💡 Business Value
This project demonstrates how raw retail data can be transformed into meaningful insights, enabling data-driven decision making.