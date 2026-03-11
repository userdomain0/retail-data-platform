from pathlib import Path
import pandas as pd
from db_connection import engine

BASE_DIR = Path(__file__).resolve().parent.parent
file_path = BASE_DIR / "data" / "raw" / "sales.csv"

df = pd.read_csv(file_path)
print(df)
"""
df.to_sql(
    "sales",
    engine,
    if_exists="append",
    index=False
)

"""