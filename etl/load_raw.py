from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

user='postgres.fjfkmzhwxlzcnfoszoyh' 
 
host='aws-1-ap-southeast-2.pooler.supabase.com'
port=6543
dbname='postgres'
psd='FXzmcMHF8nSQLa0Q' 

 
# Connect to the database
try:
    connection = psycopg2.connect(
        user=user,
        password=psd,
        host=host,
        port=port,
        dbname=dbname
    )
    print("Connection successful!")
    
    # Create a cursor to execute SQL queries
    cursor = connection.cursor()
    
    # Example query
    cursor.execute("SELECT NOW();")
    result = cursor.fetchone()
    print("Current Time:", result)

    # Close the cursor and connection
    cursor.close()
    connection.close()
    print("Connection closed.")

except Exception as e:
    print(f"Failed to connect: {e}")