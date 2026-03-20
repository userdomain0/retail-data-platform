from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine
import time

start= time.time()
BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw" / "cities.csv"

df = pd.read_csv(file_path) 
engine = get_db_engine() 

df["load_date"] = pd.Timestamp.now()
  
df.to_sql(
    "city",
    engine,
    if_exists="replace",
    schema="raw",
    index=False
)

end = time.time()
print(f'資料已完成上傳{round(end-start,0) }秒 ')