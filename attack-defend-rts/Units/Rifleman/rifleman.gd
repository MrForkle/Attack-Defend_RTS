extends RigidBody3D

var health = 100
var team = null
var speed = 3
var acceleration = 10
var moving = false
var target_position = null
@onready var nav = $NavigationAgent3D

func select():
	$"Selection Ring".show()

func deselect():
	$"Selection Ring".hide()

func set_values(team,color):
	get_node("Solid Version").mesh.material = color
	
	if team == "Red":
		collision_layer = 1 + 2 + 16384 + 32768
		collision_mask = 1 + 2 + 16384 + 32768
		$"Detection Range".collision_layer = 4
		$"Detection Range".collision_mask = 4
	elif team == "Blue":
		collision_layer = 1 + 4 + 16384 + 32768
		collision_mask = 1 + 4 + 16384 + 32768
		$"Detection Range".collision_layer = 2
		$"Detection Range".collision_mask = 2

func _process(delta):
	
	if health <= 0:
		queue_free()
	
	if target_position == null or moving != true: return
	var direction = Vector3()
	
	nav.target_position = target_position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	linear_velocity = linear_velocity.lerp(direction * speed, acceleration * delta)

func _on_navigation_agent_3d_target_reached():
	moving = false
