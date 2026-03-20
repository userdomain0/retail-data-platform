from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine

BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "sql" / "raw" / "create_raw_table.sql" 
engine = get_db_engine() 



#print("ETL 完成 🎉")       