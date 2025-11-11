extends Node

const host = "127.0.0.1"
const port = 4999
const seperation_str = '\n'
const max_request_id = 1000
const loading_symbol = "ui/sign_in_page/CenterContainer/loading_symbol"
const sign_in_page = "ui/sign_in_page/VBoxContainer"
var validation_jwt = ""
var conn = StreamPeerTCP.new()
var setup_complete = false
var incoming_data = []
var open_request_ids = []
var next_request_id = 0

func decode(data):
	var decoded = data.get_string_from_ascii()
	return decoded

func setup_connection():
	print("setting up")
	if conn.get_status() in [0,3]:
		conn.disconnect_from_host()
	var connection_established = false
	while connection_established != true:
		await get_tree().create_timer(0.1).timeout
		conn.connect_to_host(host,port)
		conn.poll()
		if conn.get_status() == StreamPeerTCP.Status.STATUS_CONNECTED:
			conn.set_no_delay(true)
			connection_established = true
		else: 
			conn.disconnect_from_host()
	setup_complete = true

func _process(_delta: float) -> void:
	return
	if setup_complete == false:
		return
	if conn.get_status() != StreamPeerTCP.Status.STATUS_CONNECTED:
		setup_complete = false
		get_parent().get_node(loading_symbol).show()
		get_parent().get_node(sign_in_page).hide()
		await setup_connection()
		get_parent().get_node(loading_symbol).hide()
		get_parent().get_node(sign_in_page).show()
	var bytes_available = conn.get_available_bytes()
	if bytes_available <= 0:
		return
	var data = conn.get_data(bytes_available)
	print("Data:" + data[1].get_string_from_ascii())
	incoming_data.append(data)

func _ready() -> void:
	await setup_connection()
	get_parent().get_node(loading_symbol).hide()
	get_parent().get_node(sign_in_page).show()

func new_request_id():
	while next_request_id in open_request_ids:
		next_request_id += 1
		if next_request_id > max_request_id:
			next_request_id = 0
	open_request_ids.append(next_request_id)
	next_request_id += 1
	return str(next_request_id-1)

func open_request(request):
	var request_id = new_request_id()
	conn.put_data((request_id + seperation_str + request).to_utf8_buffer())
	var data = ""
	while data == "":
		await get_tree().create_timer(0.01).timeout
#		print("waiting for data")
		if incoming_data != []:
			for i in range(len(incoming_data)):
				if incoming_data[i][1].get_string_from_ascii().split(seperation_str)[0] == request_id:
					data = incoming_data[i]
					incoming_data.pop_at(i)
					print("This is data:" + str(data))
					return data

func sign_in(username,password):
	var data = await open_request("sign_in" + seperation_str + username + seperation_str + password)
	var decoded = decode(data[1]).split(seperation_str)
	if decoded[1] == '0':
		validation_jwt = decoded[2]
		get_parent().get_node("ui").swap_menu("res://Menus/main_menu.tscn")
	elif decoded[1] == "1": #user doesn't exist
		pass
	elif decoded[1] == "2": #user exists but password is wrong
		pass

func sign_up(username,password):
	var data = await open_request("sign_up" + seperation_str + username + seperation_str + password)
	var decoded = decode(data[1]).split(seperation_str)
	if decoded[1] == '0':
		validation_jwt = decoded[2]
		get_parent().get_node("ui").swap_menu("res://Menus/main_menu.tscn")
