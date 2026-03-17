import psycopg2

import configparser
from sqlalchemy import create_engine

config = configparser.ConfigParser()
config.read(".\config\config.ini")

db = config["database_Neon"]

user = db["user"]
password = db["password"]
host = db["host"] 
database = db["database"]
 
conn = psycopg2.connect(
    f"postgresql://{user}:{password}@{host}/{database}?sslmode=require&channel_binding=require"
) 

cur = conn.cursor()

cur.execute("SELECT version();")
print(cur.fetchone())

conn.close()