import configparser
from sqlalchemy import create_engine
import pandas as pd

def  get_db_engine( ):
    """
    建立 MSSQL engine 連線
    """

    # 讀取設定檔
    config = configparser.ConfigParser()
    config.read('./config/config.ini')

    db = config["database"]
    user = db["username"]
    password = db["password"]
    host = db["server"] 
    database = db["database"]
    driver = db["driver"] 
    server = db["server"] 

    connection_string = (
        f"mssql+pyodbc://{user}:{password}@{server}/{database}"
        f"?driver={driver.replace(' ', '+')}"
    )

    engine = create_engine(connection_string)
    return engine
 