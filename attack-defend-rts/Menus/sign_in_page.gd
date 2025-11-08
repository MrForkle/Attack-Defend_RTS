extends Control

# Define the server's IP address and port
const host = "127.0.0.1"
const port = 4999
const seperation_str = '\n'
var conn = StreamPeerTCP.new()

func _on_button_2_pressed() -> void:
	var username = $"Username line edit".text
	var password :String = $"password line edit".text
	get_tree().get_root().get_node("Main/tcp_server").sign_up(username,password)

func _on_button_pressed() -> void:
	var username = $"Username line edit".text
	var password :String = $"password line edit".text
	get_tree().get_root().get_node("Main/tcp_server").sign_in(username,password)
