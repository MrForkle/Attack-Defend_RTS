extends Node

# Define the server's IP address and port
const host = "127.0.0.1"
const port = 4999
const seperation_str = '\n'
var conn = StreamPeerTCP.new()
var incomming_data = []

func _ready() -> void:
	connect_to_server()
	tcp_srvr_mainloop()

func sign_in(username,password):
	conn.put_data(("sign_in" + seperation_str + username + seperation_str + password).to_utf8_buffer())
	var data = []
	while data == []:
		if conn.get_available_bytes() != 0:
			data = conn.get_data(1)
		else:
			await get_tree().create_timer(0.01).timeout
	print(data[1].get_string_from_ascii())
	if data[1].get_string_from_ascii() == '0':
		get_tree().get_root().add_child(load("res://Menus/main_menu.tscn").instantiate())

func sign_up(username,password):
	conn.put_data(("sign_up" + seperation_str + username + seperation_str + password).to_utf8_buffer())
	var data = []
	while data == []:
		if conn.get_available_bytes() != 0:
			data = conn.get_data(1)
		else:
			await get_tree().create_timer(0.01).timeout
	if data[1].get_string_from_ascii() == '0':
		get_parent().get_node("ui").swap_menu("res://Menus/main_menu.tscn")

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
	get_parent().get_node("ui/sign in page/loading_symbol").hide()
	get_parent().get_node("ui/sign in page/connected_symbol").show()

func tcp_srvr_mainloop():
	while true:
		incomming_data.append(await conn.get_data(1))
