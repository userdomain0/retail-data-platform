# 開發日誌
## 2026.03.11
- 建立 github專案 retail-data-platform
- 下載 Kaggle – Grocery Sales Database 存入 data/raw 中(dataset不上傳)
## 2026.03.12
- 建立 readme.md
- 將資料庫連線資料存入 config\config.ini
- 建立 db_connection.py
- 建立 load_raw.py 將資料匯入db 
- 建立 第一個資料表 raw.sales(約67萬筆資料)

## 2026.03.20-31
- 建立 Dimension Tables（維度表）
- 建立 Fact Table（Partition）
- 建立 Clustered Columnstore Index（CCI）
- 載入 Fact（Join 維度）

- 建立 TABLE mart.product_sales
- 原始資料的金額總計均為0,在mart中重新計算 數量 *售價 *(1-折扣)