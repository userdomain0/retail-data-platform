# retail-data-platform

這是以零售業範例，所建置的數據平台DEMO
Retail Data Platform

Architecture

CSV → Python ETL → PostgreSQL → Streamlit Dashboard

Features

- Data ingestion
- Data warehouse schema
- Analytics SQL
- Web dashboard

- 開始執行時間　2026.3.10

資料來源
- Kaggle / Grocery Sales Database
- https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset/data

## Architecture 

# etl 資料搬運與處理的程式
- ETL = Extract / Transform / Load 

etl/
│
├─ load_sales.py
├─ import_csv.py
├─ transform_sales.py
└─ db_connection.py

# sql 資料腳本
sql
│
├─ raw
│   └─ create_raw_sales.sql
│
├─ staging
│   └─ clean_sales.sql
│
├─ warehouse
│   └─ fact_sales.sql
│
└─ analytics
    └─ product_ranking.sql

### Python ETL
    └ load csv → raw

### Streamlit
    └ sales dashboard
