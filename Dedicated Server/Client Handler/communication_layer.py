import psycopg2 as pg_interface

POSTGRES_DATABASE_NAME = "rts_database"
HOST = "127.0.0.1"
PORT = 5432
USERNAME = "postgres"
PASSWORD = "password"
DB = "rts_database"
DSN_STRING = f"user={USERNAME} password={PASSWORD} " \
             f"dbname={DB} host={HOST} port={PORT}"


def run_query(q,params=(), has_results=False, commit=True):
    with conn.cursor() as cursor:
        if params == ():
            cursor.execute(q)
        else:
            cursor.execute(q,vars=params)
        if has_results == True:
            try:
                results = cursor.fetchall()
                return results
            except psycopg2.NoResults:
                return []
    if commit:
        conn.commit()

def init_db_conn():
    global conn 
    conn = pg_interface.connect(dsn=DSN_STRING)


def init_postgres_tables():
    init_db_conn()
    query = '''
    CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        id_salt INTEGER NOT NULL,
        name TEXT NOT NULL,
        hashed_password TEXT NOT NULL,
        password_salt INTEGER NOT NULL
    );
    CREATE TABLE IF NOT EXISTS global_chat (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        hashed_password TEXT NOT NULL,
        password_salt INTEGER NOT NULL
    );
    '''
    run_query(query)
    conn.close()


def get_entries(table,columns,search_keywords,boolean="AND"):
    #create the query
    query = f"SELECT * FROM {table} WHERE {columns[0]} = \'{search_keywords[0]}\'"

    if len(columns) != 1:
        for i in range(len(columns)):
            if i == 0: 
                continue
            query += " " + boolean + f" {columns[i]} = {search_keywords[i]}"
    return run_query(query,has_results=True)


def get_all_entries(table):
    query = f"select * from {table}"
    return run_query(query,has_results=True)

def add_entry(table,column_values : tuple):
    query = f"INSERT INTO {table} \n VALUES ("
    for i in range(len(column_values)):
        query += "%s"
        if i != (len(column_values)-1):
            query += ", "
    query += ")"
    run_query(q=query,params=column_values)