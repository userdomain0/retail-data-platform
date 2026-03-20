from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine

BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw" / "sales.csv" 
engine = get_db_engine()   
chunk_size = 10000

for chunk in pd.read_csv(file_path, chunksize=chunk_size):

    # 欄位統一
    chunk.columns = chunk.columns.str.lower()

    # 重新命名
    chunk = chunk.rename(columns={
        "salesdate": "sale_date",
        "productid": "product_id",
        "totalprice": "sales_amount"
    })

    # 補 store_id（目前資料沒有）
    #chunk["store_id"] = 1

    # 保留需要欄位
    chunk = chunk[["sale_date",  "product_id", "sales_amount"]]

    # 日期格式
    chunk["sale_date"] = pd.to_datetime(chunk["sale_date"])

    # 寫入資料庫
    chunk.to_sql("sales", engine, if_exists="append", index=False)

    print(f"Inserted {len(chunk)} rows")

print("ETL 完成 🎉")