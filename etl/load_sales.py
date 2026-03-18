from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine

BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw" / "sales.csv" 
engine = get_db_engine()
chunk_size = 10000

for chunk in pd.read_csv(file_path, chunksize=chunk_size):

    chunk.columns = chunk.columns.str.lower()

    chunk = chunk.rename(columns={
        "date": "sale_date",
        "store_nbr": "store_id",
        "sales": "sales_amount"
    })

    chunk["product_id"] = chunk["family"].astype("category").cat.codes
    chunk = chunk[["sale_date", "store_id", "product_id", "sales_amount"]]
    chunk["sale_date"] = pd.to_datetime(chunk["sale_date"])
    chunk.to_sql("sales", engine, if_exists="append", index=False)
    print(f"Inserted {len(chunk)} rows")