import psycopg2

conn = psycopg2.connect(
    f"postgresql://neondb_owner:{psd}@ep-broad-bird-a13c7d1z-pooler.ap-southeast-1.aws.neon.tech/{dbname}?sslmode=require&channel_binding=require"
)

cur = conn.cursor()

cur.execute("SELECT version();")
print(cur.fetchone())

conn.close()