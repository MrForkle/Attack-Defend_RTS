extends Node3D
@onready var red_material := StandardMaterial3D.new()
@onready var blue_material := StandardMaterial3D.new()
var player_team = "blue"
var units = {
	"Rifleman" = preload('res://Units/Rifleman/rifleman.tscn')
}

func _ready():
	red_material.albedo_color = Color("red")
	blue_material.albedo_color = Color("blue")

func _on_timer_timeout() -> void:
	spawn_unit("Rifleman","red")

func get_random_spawn_position():
	var return_value = Vector3(0,0,0)
	var spawn_points = $"Spawn Points".get_children()
	return_value = spawn_points.pick_random().global_position
	return return_value

func spawn_unit(unit,team):
	unit = units[unit]
	var unit_instantiated = unit.instantiate()
	unit_instantiated.position = get_random_spawn_position()
	var color = null
	if team == "red":
		color = get_tree().get_root().get_node("Map").red_material
	elif team == "blue":
		color = get_tree().get_root().get_node("Map").blue_material
	unit_instantiated.set_values(team,color,Vector3(-2.36,12.014,22.78))
	get_tree().get_root().get_node("Map").add_child(unit_instantiated)
