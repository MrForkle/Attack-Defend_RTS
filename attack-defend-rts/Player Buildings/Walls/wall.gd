extends StaticBody3D

@onready var camera_path = get_tree().get_root().get_node("Map").get_node("Camera").get_node("Player Camera")
var health = 1000
var team = null

func set_values(set_team,color):
	team = set_team
	get_node("MeshInstance3D").mesh.material = color
	if team == "red":
		collision_layer = 1 + 2 + 16384 + 32768
		collision_mask = 1 + 2 + 16384 + 32768
	elif team == "blue":
		collision_layer = 1 + 4 + 16384 + 32768
		collision_mask = 1 + 4 + 16384 + 32768

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()
	if is_in_group("Placing"):
		var raycast_result = camera_path.shoot_ray()
		if raycast_result != null:
			position = raycast_result["position"]

func begin_placing():
	$CollisionShape3D.disabled = true
	add_to_group("Placing")

func end_placing():
	remove_from_group("Placing")
	reparent(get_parent().get_node("Non Navigation Buildings"))
	$CollisionShape3D.disabled = false
