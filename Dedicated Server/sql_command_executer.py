import psycopg2 as pg_interface, sqlalchemy

POSTGRES_DATABASE_NAME = "rts_database"
HOST = "127.0.0.1"
PORT = 5432
USERNAME = "postgres"
PASSWORD = "password"
DB = "rts_database"
DSN_STRING = f"user={USERNAME} password={PASSWORD} " \
             f"dbname={DB} host={HOST} port={PORT}"

with pg_interface.connect(dsn=DSN_STRING) as conn:
    with conn.cursor() as cursor:
        cursor.execute("DROP TABLE IF EXISTS users CASCADE;")
        conn.commit()