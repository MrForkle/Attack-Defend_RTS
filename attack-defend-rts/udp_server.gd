extends Node

const host = "127.0.0.1"
const port = 5001
const seperation_str = '\n'
var udp = PacketPeerUDP.new()
var connected = false
var incomming_data = []

func _ready():
	udp.connect_to_host(host,port)

func _process(_delta):
	return
	if udp.get_available_packet_count() > 0:
		incomming_data.append(udp.get_packet().get_string_from_utf8())

func send_packet(data):
	udp.put_packet(data.to_utf8_buffer())

func connect_to_chat(chat_name):
	send_packet("connect\n" + chat_name)
	
