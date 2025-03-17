import psycopg2 as pg_interface, sqlalchemy

POSTGRES_DATABASE_NAME = "rts_database"

HOST = "127.0.0.1"
PORT = 5432
USERNAME = "postgres"
PASSWORD = "password"
DB = "rts_database"
DSN_STRING = f"user={USERNAME} password={PASSWORD} " \
             f"dbname={DB} host={HOST} port={PORT}"


def run_query(q, has_results=False, commit=True):
    with pg_interface.connect(dsn=DSN_STRING) as conn:
        with conn.cursor() as cursor:
            cursor.execute(q)
            if has_results == True:
                try:
                    return cursor.fetchall()
                except psycopg2.NoResults:
                    return []
        if commit:
            conn.commit()



def init_postgres_tables():
    query = '''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        hashed_password TEXT NOT NULL
    )'''
    run_query(query)


def get_entries(table,column,search_keyword):
    #create the query
    query = f"SELECT {column} FROM {table} WHERE {column} = ?"
    run_query(query,has_results=True)


def get_all_records(table):
    query = f"select * from {table}"
    return run_query(query,has_results=True)

def add_entry(table,column_values : tuple):
    query = '''INSERT INTO table_name
    VALUES 
    '''
    values = ""
    for i in column_values:
        values.
