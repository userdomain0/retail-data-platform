# 📊 Retail Data Platform (End-to-End)

## 📌 Overview

This project demonstrates an end-to-end retail data platform, covering data ingestion, data warehouse design (MSSQL), data mart modeling, and BI visualization.

It simulates a real-world enterprise scenario where raw data is transformed into business-ready insights through a structured data pipeline.

---

## 🏗️ Architecture

```
Data Source → Ingestion → Raw → Staging → Data Warehouse → Data Mart → BI → Notification
```

---

## 🛠 Tech Stack

* Python (Pandas)
* Microsoft SQL Server (MSSQL)
* SQL (T-SQL)
* Tableau (Public / Desktop / Server)
* GitHub

---

## 🏗 資料來源

* Kaggle / Grocery Sales Database
* https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset/data

---

## 🧱 Data Warehouse Design

### Data Layers

* **Raw Layer**
  Stores original source data without transformation

* **Staging Layer**
  Handles data cleaning, standardization, and transformation

* **Data Warehouse Layer**
  Implements star schema for analytical querying

* **Data Mart Layer**
  Provides pre-aggregated, BI-ready datasets

---

## ⭐ Data Model (Star Schema)

### Fact Table

* **fact_sales**

### Dimension Tables

* **dim_product**
* **dim_store**
* **dim_date**

---

## ⚙️ ETL Pipeline

* Data ingestion using Python
* Transformation via T-SQL stored procedures
* Incremental loading strategy:

  * Only refresh latest **180 days** of data
* Scheduled execution via SQL Server Agent

---

## 📈 Data Mart

### mart_store_product_sales

Pre-aggregated table designed for BI consumption

Includes:

* store_id
* product_id
* total_quantity
* total_sales

---

## 📊 Visualization Strategy

* **Tableau Public**
  Used for portfolio demonstration and public sharing

* **Tableau Desktop / Server**
  Applicable in enterprise environments for:

  * Secure data access
  * Scheduled refresh
  * Role-based dashboards

---

## 📈 Dashboard Use Cases

* Product sales ranking
* Store performance analysis
* Category contribution analysis

---

## 🚀 Key Features

* End-to-end data pipeline design
* Star schema modeling (fact & dimension tables)
* Incremental data loading for performance optimization
* Partition-ready large dataset design
* BI-ready data mart layer

---

## 🔔 Automation

* SQL Server Agent for scheduling ETL jobs
* Email / LINE notification integration

---

## 💡 Design Considerations

* **Why staging layer?**
  To isolate raw data and ensure clean transformations before loading into DW

* **Why data mart?**
  To improve BI performance by reducing real-time aggregation

* **Why incremental load?**
  To avoid full table scans and improve processing efficiency

---

## 📌 Future Improvements

* Implement Slowly Changing Dimensions (SCD)
* Add data quality validation checks
* Integrate Airflow for workflow orchestration
* Deploy to cloud data platform (e.g., Azure / GCP)
