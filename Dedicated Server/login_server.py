import sqlite3,socket,time,asyncio

# Define the server's IP address and port
HOST = '127.0.0.1'  # Localhost
PORT = 4999        # Port to listen on
USERS_DB = "../Server Data/users.db"

def main():
    conn = sqlite3.connect(USERS_DB)
    cursor = conn.cursor()

    cursor.execute('''
    CREATE TABLE IF NOT EXISTS Users (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        hashed_password TEXT NOT NULL
    )
    ''')

    srvr_mainloop()

def add_usr(id,name,hashed_password):
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()

    # Insert data
    cursor.execute('''
    INSERT INTO Users (id, name, email) VALUES (?, ?, ?)
    ''', (1, 'Michal', 'michal@example.com'))

    # Commit the transaction
    conn.commit()

def srvr_mainloop():
    while True:
        # Create a socket object
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
            # Bind the socket to the address and port
            server_socket.bind((HOST, PORT))
            
            # Listen for incoming connections
            server_socket.listen()
            print(f"Server listening on {HOST}:{PORT}")
            
            # Accept a connection
            conn, addr = server_socket.accept()
            with conn:
                print(f"Connected by {addr}")
                while True:
                    # Receive data from the client
                    data = conn.recv(1024)
                    if not data:
                        break
                    print(f"Received:" + str(data.decode()))

if __name__ == "__main__":
    main()