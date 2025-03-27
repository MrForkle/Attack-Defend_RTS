import sqlite3,socket,time,asyncio,communication_layer
import random,hashlib

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
    user = communication_layer.get_entries("users",("name",),(username,))

    if user == []:
        return 2

    entered_hashed_password = hashlib.sha512((password + str(user[0][4])).encode("utf-8"))
    entered_hashed_password = entered_hashed_password.hexdigest()

    comparison_failed = False
    for i in range(len(entered_hashed_password)):
        if entered_hashed_password[i] != user[0][3][i]:
            comparison_failed = True
    if comparison_failed == True:
        return 1
    elif comparison_failed == False:
        return 0



def add_user(username,password):
    if communication_layer.get_entries("users",("name",),(username,)) != []:
        return 1
    
    unique = [""]
    while unique != []:
        salt = random.randint(0,100000)
        user_id = hashlib.sha512((username+str(salt)).encode("utf-8"))
        user_id = user_id.hexdigest()
        unique = communication_layer.get_entries("users",("id",),(user_id,))
    
    password_salt = random.randint(0,100000)
    hashed_password = hashlib.sha512((password+str(password_salt)).encode("utf-8"))
    hashed_password = hashed_password.hexdigest()
    
    communication_layer.add_entry("users",(user_id,salt,username,hashed_password,password_salt))
    return 0

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
                    if data[0] == "login":
                        print("login")
                        data = login(data[1],data[2])
                        print(data)
                        data = str(data)
                        data = data.encode("utf-8")
                        conn.send(data)
                    elif data[0] == "sign_up":
                        print("Sign up")
                        print(add_user(data[1],data[2]))
                    
if __name__ == "__main__":
    print(main())