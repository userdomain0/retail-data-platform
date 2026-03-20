from pathlib import Path
import pandas as pd
from  config.db_connection import get_db_engine
from sqlalchemy import text

import time,os

start= time.time()
BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw"  
file=os.listdir(file_path)
file=[f for f in file if "sales" not in f] #sales檔案較大,單獨處理
#連線資料庫
engine = get_db_engine() 
#將舊資料表刪除後,重新載入
def delete_table():
    f_path=f'{BASE_DIR}/sql/create_raw_table.sql'
    with open(f_path,encoding='utf-8') as f:
        sql_text=f.read()

    with engine.connect() as conn:
        conn.execute(text(sql_text))
        conn.commit()

def load_data(file_name):
    #csv檔修改為>資料表名稱
    f_name=file_name.replace('.csv','').replace('ies','y') 
    
    csv_path = BASE_DIR / "data" / "raw" / file_name
    df = pd.read_csv(csv_path) 
    df["load_date"] = pd.Timestamp.now() 
    n=len(df)
    try:
        df.to_sql(
            f_name,
            engine,
            if_exists="append",
            schema="raw",
            index=False
        )


        print(f'{file_name} 完成資料載入 {f_name} 共{n}筆資料')
    except Exception as e:
        print(f'{file_name} 完成資料失敗 {e}  ')


delete_table()
for i in file:
    load_data(i)
    



