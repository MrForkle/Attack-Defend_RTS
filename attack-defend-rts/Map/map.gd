extends Node3D
@onready var red_material := StandardMaterial3D.new()
@onready var blue_material := StandardMaterial3D.new()
var player_team = "blue"

func _ready():
	red_material.albedo_color = Color("red")
	blue_material.albedo_color = Color("blue")
