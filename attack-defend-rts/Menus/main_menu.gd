extends Control

const MAX_CLIENTS = 4095
const PORT = 5000

var map = preload("res://Map/map.tscn")

@rpc("any_peer","reliable","call_remote")
func check_connection():
	return 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	var cmdline_args = OS.get_cmdline_args()
	if "--server_mode" in cmdline_args:
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(PORT, MAX_CLIENTS)
		multiplayer.multiplayer_peer = peer
	else:
		var connection_established = false
		var wait_time = 0.01
		var IP_ADDRESS = "127.0.0.1"
		while connection_established != true:
			await get_tree().create_timer(wait_time).timeout
			var peer = ENetMultiplayerPeer.new()
			peer.create_client(IP_ADDRESS, PORT)
			multiplayer.multiplayer_peer = peer
			var err_code = rpc("check_connection")
			if err_code == 0:
				if wait_time == 0.01:
					OS.alert("Could not connect to server.\nPlease check your internet connection.",
					"Connection Issue")
				wait_time = wait_time * 1.25
			else:
				print("connected")
				connection_established = true
		if wait_time != 0.01:
			OS.alert("Connection successful.",
					"Connection")

func _on_level_select_button_pressed() -> void:
	get_node("Main menu").hide()
	get_node("Level Select").show()

func _on_join_game_button_pressed() -> void:
	get_node("Join Game").show()
	get_node("Main menu").hide()

func _on_options_button_pressed() -> void:
	get_node("Options").show()
	get_node("Main menu").hide()

func _on_close_pressed() -> void:
	get_node("Options").hide()
	get_node("Main menu").show()

func _on_level_one_button_pressed() -> void:
	var map_instantiated = map.instantiate()
	get_tree().get_root().get_node("Main/ui").add_child(map_instantiated)
	hide()
