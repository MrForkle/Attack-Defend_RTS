extends Node3D
#1sdsds
@onready var red_material := StandardMaterial3D.new()
@onready var blue_material := StandardMaterial3D.new()

func _ready():
	red_material.albedo_color = Color("Red")
	blue_material.albedo_color = Color("Blue")
