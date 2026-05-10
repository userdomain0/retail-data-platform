from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine
import time


BASE_DIR = Path(__file__).resolve().parent.parent


f_name=['cities','categories','countries','customers','employees','products']
sql_name=['city','category','country','customers','employees','products']

n=len(f_name)
for i in range(n):
    start= time.time()
    fn=f'{f_name[i]}.csv'
    sn=f'{sql_name[i]}'
    file_path = BASE_DIR / "data" / "raw" / fn

    df = pd.read_csv(file_path) 
    engine = get_db_engine() 

    df["load_date"] = pd.Timestamp.now()
    try:
        
        df.to_sql(
            sn,
            engine,
            if_exists="replace",
            schema="raw",
            index=False
        )

        end = time.time()
        print(f'{sn}資料已完成上傳{round(end-start,0) }秒 ')
    
    except:
        print(f'{sn}資料已上傳 失敗 ')


