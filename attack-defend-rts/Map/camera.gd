extends Node3D

var rotating = 0
var positioning = Vector3(0,0,0)

func _process(_delta):
	rotation.y += rotating
	position += to_global(positioning)-position

func on_left_click():
	var raycat_result = $"Player Camera".shoot_ray()
	var nodes = get_tree().get_nodes_in_group("Placing")
	for i in nodes:
		i.end_placing()
	if raycat_result == null:
		return
	var selected = raycat_result["collider"]
	nodes = get_tree().get_nodes_in_group("Selected")
	if selected.is_in_group("Building"):
		for i in nodes:
			i.deselect()
	nodes = get_tree().get_nodes_in_group("Selected")
	if selected.is_in_group("Unit"):
		for i in nodes:
			if i.is_in_group("Unit") != true:
				i.deselect()
	nodes = get_tree().get_nodes_in_group("Selected")
	if selected.is_in_group("Selectable"):
		selected.select()
	nodes = get_tree().get_nodes_in_group("Selected")

func on_right_click():
	var nodes = get_tree().get_nodes_in_group("Selected")
	var raycat_result = $"Player Camera".shoot_ray()
	if raycat_result == null:
		return
	for i in nodes:
		if i.is_in_group("Building") != true:
			i.set_target_position(raycat_result['position'])

func _input(event):
	if event.is_action("Camera Turn Left") and event.is_pressed():
		rotating = deg_to_rad(3)
	elif event.is_action("Camera Turn Left") and event.is_released():
		rotating = deg_to_rad(0)
	elif  event.is_action("Camera Turn Right") and event.is_pressed():
		rotating = deg_to_rad(-3)
	elif event.is_action("Camera Turn Right") and event.is_released():
		rotating = deg_to_rad(0)
	elif event.is_action("w") and event.is_pressed():
		positioning.z = -0.3
	elif event.is_action("w") and event.is_released():
		positioning.z = 0
	elif event.is_action("s") and event.is_pressed():
		positioning.z = 0.3
	elif event.is_action("s") and event.is_released():
		positioning.z = 0
	elif event.is_action("a") and event.is_pressed():
		positioning.x = -0.3
	elif event.is_action("a") and event.is_released():
		positioning.x = 0
	elif event.is_action("d") and event.is_pressed():
		positioning.x = 0.3
	elif event.is_action("d") and event.is_released():
		positioning.x = 0
	elif event.is_action("Left Click") and event.is_pressed():
		on_left_click()
	elif event.is_action("Right Click") and event.is_pressed():
		on_right_click()
