import sqlite3
import socket
import time
import multiprocessing
from multiprocessing import reduction
from multiprocessing import Pipe
from multiprocessing import Process
from multiprocessing import connection
import random
import hashlib
import select
import os

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.backends import default_backend

import communication_layer

# Define the server's IP address and port
HOST = '0.0.0.0'  # Localhost
PORT = 4999        # Port to listen on



def main():
    create_threadpool()
    communication_layer.init_postgres_tables()
    srvr_mainloop()

def create_threadpool(size=5): #Init Threads for client handling
    global threadpool
    threadpool = []

    for i in range(size):
        child_pipe, parent_pipe = Pipe(duplex=True) #Create a pipe for passing the client connection
        new_thread = Process(target=client_handler,args=(child_pipe,)) #Prepare the New Thread
        new_thread.start()
        threadpool.append((new_thread,parent_pipe)) #append the thread object and pipe

def client_handler(local_pipe):

    print("hello world")

    communication_layer.init_db_conn()

    connections = []

    while True:
        if local_pipe.poll():
            pipe_output = multiprocessing.reduction.recv_handle(local_pipe)
            new_socket = socket.fromfd(pipe_output, socket.AF_INET, socket.SOCK_STREAM)
            print("New socket: " + str(new_socket))
            connections.append(new_socket)
            os.close(pipe_output)

        if connections == []:
            time.sleep(0.01)
            continue

        readable,writable,errors = select.select(connections,[],connections,0.01)

        if readable == [] and errors == []:
            continue

        for conn in readable:
            # Receive data from the client
            data = conn.recv(1024)
            if data == b'':
                index = connections.index(conn)
                conn.close()
                connections.pop(index)
            print(data)
            data = data.decode("utf-8")
            print(data)
            data = data.split("\n")
            print(data)
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
        
        for i in errors:
            i.close()

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
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        # Bind the socket to the address and port
        server_socket.bind((HOST, PORT))
        thread_to_use = 0
        while True: 
            # Listen for incoming connections
            server_socket.listen()
            print(f"Server listening on {HOST}:{PORT}")
                    
            # Accept a connection
            conn, addr = server_socket.accept()
            parent_pipe = threadpool[thread_to_use][1]
            thread = threadpool[thread_to_use][0]

            multiprocessing.reduction.send_handle(parent_pipe, conn.fileno(), thread.pid)
            if thread_to_use >= (len(threadpool)-1):
                thread_to_use = 0
            else:
                thread_to_use += 1 
         
if __name__ == "__main__":
    main()