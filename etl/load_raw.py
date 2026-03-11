from pathlib import Path
import pandas as pd
from db_connection import engine
import time

start= time.time()
BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw" / "sales.csv"

df = pd.read_csv(file_path) 
engine.dispose()
df.to_sql(
    "sales",
    engine,
    if_exists="replace",
    schema="raw",
    index=False,
    chunksize=10000,
    method='multi'
)

end = time.time()
print(f'資料已完成上傳{round(end-start,0) }秒 ')