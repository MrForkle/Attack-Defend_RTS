extends Button

var message := 0
var messages = ["Not enough money!","NOT ENOUGH MONEY!","I Said not enough money!","Are you not reading these.","What's wrong with you?","STOP IT!","I said STOP!"]
var rifleman = preload("res://Units/Rifleman/rifleman.tscn")

func _pressed():
	if get_parent().get_node("Label").money <= 100:
		OS.alert(messages[message])
		if message < len(messages)-1:
			message += 1
		return
	get_parent().get_node("Label").money -= 100
	var rifleman_instantiated = rifleman.instantiate()
	rifleman_instantiated.add_to_group("Placing")
	if $Red.button_pressed == true:
		rifleman_instantiated.get_node("Solid Version").mesh.material = get_tree().get_root().get_node("Map").red_material
		rifleman_instantiated.get_node("Phantom Version").mesh.material = get_tree().get_root().get_node("Map").red_material
		rifleman_instantiated.team = "Red"
	elif $Blue.button_pressed == true:
		rifleman_instantiated.get_node("Phantom Version").mesh.material = get_tree().get_root().get_node("Map").blue_material
		rifleman_instantiated.get_node("Solid Version").mesh.material = get_tree().get_root().get_node("Map").blue_material
		rifleman_instantiated.team = "Blue"
	get_tree().get_root().get_node("Map").add_child(rifleman_instantiated)
