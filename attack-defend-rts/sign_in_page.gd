extends Control

# Define the server's IP address and port
const host = "127.0.0.1"
const port = 4999
var conn = StreamPeerTCP.new()

func _ready() -> void:
	connect_to_server()

func connect_to_server():
	conn.connect_to_host(host,port)
	var message = "hello"
	var wait_time = 0.1
	var connection_established = false
	while connection_established != true:
		await get_tree().create_timer(wait_time).timeout
		conn.poll()
		print(conn.get_status())
		if conn.get_status() == StreamPeerTCP.Status.STATUS_CONNECTED:
			conn.set_no_delay(true)
			conn.put_utf8_string(message)
			connection_established = true
		print("waiting")
		wait_time *= 1.1
