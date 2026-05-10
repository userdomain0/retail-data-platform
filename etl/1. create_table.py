from pathlib import Path
import pandas as pd
from sqlalchemy import text
from  config.db_connection import get_db_engine

BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "sql" / "raw" / "create_raw_table.sql" 
engine = get_db_engine() 

with open(file_path, "r", encoding="utf-8") as f:
    sql = f.read()

with engine.connect() as conn:
    conn.execute(text(sql))
    conn.commit()

print("raw table 建立完成")

#print("ETL 完成 🎉")       