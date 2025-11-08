import socket
import docker

import sys
sys.path.append('/main/communication_layer')
import communication_layer

conn = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

def connect():
    pass

def create_chat(name):
    print(f"Created chat in container {name}",flush=True)
    client.containers.run("chat_server_child",hostname=name,detach=True,network="dedicated_server_default")

commands = {
    "connect" : connect
}

def mainloop():
    while True:
        #conn.sendto(''.encode(), (args.ip, args.server_port))
        data, server_address = conn.recvfrom(1024)
        print(f'Received {data.decode("utf-8")}',flush=True)

def init():
    create_chat("global")
    mainloop()

def main():
    global client
    client = docker.client.from_env()
    init()

if __name__ == "__main__":
    main()