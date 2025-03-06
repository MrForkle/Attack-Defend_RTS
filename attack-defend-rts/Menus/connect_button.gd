extends Button
const PORT = 5000

func _on_pressed() -> void:
	var IP_ADDRESS = get_parent().get_node("LineEdit").text
	var peer = ENetMultiplayerPeer.new()
	var err_code = peer.create_client(IP_ADDRESS, PORT)
	if err_code != 0:
		OS.alert("Inputed IP address is invalid. Please try a new input.\n" + 
		"This can also be caused if the server is not online, you may need to try again later\n" +
		"Error Code: " + str(err_code),
		"Invalid IP address")
	multiplayer.multiplayer_peer = peer
	
