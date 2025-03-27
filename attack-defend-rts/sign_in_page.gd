extends Control

# Define the server's IP address and port
const host = "127.0.0.1"
const port = 4999
const seperation_str = '\n'
var conn = StreamPeerTCP.new()

func _ready() -> void:
	connect_to_server()

func connect_to_server():
	conn.connect_to_host(host,port)
	var wait_time = 0.1
	var connection_established = false
	while connection_established != true:
		await get_tree().create_timer(wait_time).timeout
		conn.poll()
		print(conn.get_status())
		if conn.get_status() == StreamPeerTCP.Status.STATUS_CONNECTED:
			conn.set_no_delay(true)
			connection_established = true
				
		wait_time *= 1.1

func sign_in():
	var username = $"Username line edit".text
	var password :String = $"password line edit".text
	conn.put_data(("login" + seperation_str + username + seperation_str + password).to_utf8_buffer())
	var data = conn.get_data(1)
	print(data[1].get_string_from_ascii())

func sign_up():
	var username = $"Username line edit".text
	var password :String = $"password line edit".text
	conn.put_data(("sign_up" + seperation_str + username + seperation_str + password).to_utf8_buffer())

func _on_button_2_pressed() -> void:
	sign_up()

func _on_button_pressed() -> void:
	sign_in()
