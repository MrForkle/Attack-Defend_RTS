extends Area3D

var red_material
var blue_material
var red_count = 0
var blue_count = 0

func _ready() -> void:
	red_material = get_tree().get_root().get_node("Map").red_material
	blue_material = get_tree().get_root().get_node("Map").blue_material
	$RigidBody3D/MeshInstance3D.mesh.material.albedo_color = Color("blue")
	$RigidBody3D/MeshInstance3D2.mesh.material.albedo_color = Color("blue")

func update_capture_point():
	red_count = 0
	blue_count = 0
	var overlapping_bodies = get_overlapping_bodies()
	for i in overlapping_bodies:
		if i.is_in_group("Unit"):
			if i.team == "red":
				red_count += 1
			elif i.team == "blue":
				blue_count += 1
	if red_count > blue_count:
		$RigidBody3D/MeshInstance3D.mesh.material.albedo_color = Color("red")
		$RigidBody3D/MeshInstance3D2.mesh.material.albedo_color = Color("red")
		OS.alert("You Lost!")
		get_tree().quit()
	elif red_count < blue_count:
		$RigidBody3D/MeshInstance3D.mesh.material.albedo_color = Color("blue")
		$RigidBody3D/MeshInstance3D2.mesh.material.albedo_color = Color("blue")

func _on_body_entered(_body: Node3D) -> void:
	update_capture_point()

func _on_body_exited(_body: Node3D) -> void:
	update_capture_point()
