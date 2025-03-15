import psycopg2 as pg_interface

DATABASE_NAME = "rts_database"
PORT = 5432
USERNAME = "postgres"
PASSWORD = "password"

def add_usr(user_id,name,hashed_password):
    conn = pg_interface.connect()
    cursor = conn.cursor()
    query = 'SELECT name FROM Users WHERE name = ?'
    cursor.execute(query,(name))
    row = cursor.fetchone() #since name is unique, you'd only get the next row 
    if row[0]: #if name is returned
        return 1
    
    query = 'SELECT id FROM Users WHERE id = ?'
    cursor.execute(query,(user_id))
    row = cursor.fetchone() #since userID is unique, you'd only get the next row 
    if row[0]: #if userID is returned
        return 2
        
    # Insert data
    cursor.execute('''
    INSERT INTO Users (id, name, hashed_password) VALUES (?, ?, ?)
    ''', (user_id,name,hashed_password))

    # Commit the transaction
    conn.commit()
    return 0

def get_entries(table,column,search_keyword):
    #create the query
    query = "SELECT " + column + " FROM " + table + " WHERE " + column + " = ?"
    try: #attempt to connect to server return error code if ther is a failure
        conn = pg_interface.connect()
        cursor = conn.cursor()
    except:
        return 1
    cursor.execute(query,(search_keyword)) #execute query
    result = cursor.fetchone()#fetch results
    