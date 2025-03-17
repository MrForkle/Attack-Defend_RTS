import sqlite3,socket,time,asyncio,communication_layer

# Define the server's IP address and port
HOST = '127.0.0.1'  # Localhost
PORT = 4999        # Port to listen on
USERS_DB = "../Server Data/users.db"

def main():
    communication_layer.init_postgres_tables()
    srvr_mainloop()

async def client_handler(client):
    pass

def login(username,password):
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
                    if data[-1] == "login":
                        login(data[0],data[1])
                print(communication_layer.get_all_records("users"))
                    
if __name__ == "__main__":
    print(main())