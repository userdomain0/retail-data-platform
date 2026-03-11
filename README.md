# Retail Data Platform
This project simulates a retail data platform for analyzing grocery store sales data.

The system uses the public dataset **Grocery Sales Database from Kaggle** to simulate a multi-store retail environment.

Sales data is ingested into a cloud PostgreSQL database, processed through a Python ETL pipeline, and transformed into a data warehouse model for analytics.

The goal of this project is to demonstrate practical data engineering concepts including:

- Data ingestion
- ETL pipeline design
- Data warehouse modeling
- Analytics queries
- Dashboard visualization

## Dataset

Dataset source:

Kaggle – Grocery Sales Database

This dataset simulates grocery store transactions including:

- sales transactions
- products
- stores
- categories
- inventory related data


# Infrastructure

The project uses a cloud-based PostgreSQL database for data storage.

Data workflow:

Kaggle Dataset  
↓  
Python ETL  
↓  
Cloud PostgreSQL  
↓  
Data Warehouse  
↓  
Analytics / Dashboard


## Tech Stack

- Python
- PostgreSQL (Cloud)
- Supabase (Cloud Database)
- Pandas
- Streamlit
- SQL
- GitHub


## Data Platform Architecture
Kaggle Dataset
        │
        ▼
Python ETL
        │
        ▼
Cloud PostgreSQL
        │
        ▼
Data Warehouse
        │
        ▼
Analytics Layer
        │
        ▼
Streamlit Dashboard

## Data Source
- Kaggle / Grocery Sales Database
- https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset/data