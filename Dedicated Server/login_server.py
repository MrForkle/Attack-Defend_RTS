import sqlite3,socket,time,asyncio,ccommunication_layer

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

async def client_handler(client):
    pass

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
                    data = data.decode()
                    data = data.split("\n")
                    
if __name__ == "__main__":
    main()