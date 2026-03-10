# retail-data-platform

這是以零售業範例，所建置的數據平台DEMO

開始執行時間　2026.3.10
## 資料來源
Kaggle / Grocery Sales Database
https://www.kaggle.com/datasets/andrexibiza/grocery-sales-dataset/data
## Architecture 
### PostgreSQL (Supabase) 
    ├ raw
    ├ staging
    └ mart

### Python ETL
    └ load csv → raw

### Streamlit
    └ sales dashboard
