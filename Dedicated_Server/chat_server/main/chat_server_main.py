import socket
import docker

import sys
sys.path.append('/main/communication_layer')
import communication_layer

def main():
    client = docker.client.from_env()
    print(client.containers.get('chat_server'),flush=True)
    #client.containers.run("chat_server_child",detach=True)
    

if __name__ == "__main__":
    main()