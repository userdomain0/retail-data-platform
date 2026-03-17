import psycopg2

conn = psycopg2.connect(
    "postgresql://neondb_owner:npg_FSAsy0jp6CrG@ep-broad-bird-a13c7d1z-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require"
)

cur = conn.cursor()

cur.execute("SELECT version();")
print(cur.fetchone())

conn.close()