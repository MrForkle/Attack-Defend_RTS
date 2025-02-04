extends StaticBody3D
@onready var camera_path = get_tree().get_root().get_node("Map").get_node("Camera").get_node("Player Camera")
var units = {
	"Rifleman" = {
		"path" = preload('res://Units/Rifleman/rifleman.tscn'),
		"cost" = 100
		}
}

func _process(_delta: float) -> void:
	if is_in_group("Placing"):
		var raycast_result = camera_path.shoot_ray()
		if raycast_result != null:
			position = raycast_result["position"]

func begin_placing():
	$CollisionShape3D.disabled = true
	add_to_group("Placing")

func end_placing():
	remove_from_group("Placing")
	reparent(get_parent().get_node("NavigationRegion3D"))
	$CollisionShape3D.disabled = false

func select():
	$CanvasLayer.show()
	$"Selection Indicator".show()
	add_to_group("Selected")

func deselect():
	$CanvasLayer.hide()
	$"Selection Indicator".hide()
	remove_from_group("Selected")

func spawn_unit(unit,team):
	if get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").check_money(units[unit]["cost"]) != true:
		return
	get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").update_money(-units[unit]["cost"])
	unit = units[unit]["path"]
	var unit_instantiated = unit.instantiate()
	unit_instantiated.position = $"Spawn Point".global_position
	var color = null
	if team == "red":
		color = get_tree().get_root().get_node("Map").red_material
	elif team == "blue":
		color = get_tree().get_root().get_node("Map").blue_material
	unit_instantiated.set_values(team,color,to_global(Vector3(3,0,0)))
	get_tree().get_root().get_node("Map").add_child(unit_instantiated)
