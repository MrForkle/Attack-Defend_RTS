import socket
import docker

import sys
sys.path.append('/main/communication_layer')
import communication_layer

conn = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

def connect():
    pass

def create_chat():
    pass

commands = {
    "connect" : connect
}

def mainloop():
    while True:
        #conn.sendto(''.encode(), (args.ip, args.server_port))
        data, server_address = client_socket.recvfrom(1024)
        print(f'Received {data.decode("utf-8")}')

def init():
    create_chat("main")

def main():
    client = docker.client.from_env()
    init()
    print(client.containers.get('chat_server'),flush=True)
    client.containers.run("chat_server_child",detach=True,network="dedicated_server_default")

if __name__ == "__main__":
    main()