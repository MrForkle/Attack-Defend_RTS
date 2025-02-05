extends RigidBody3D

var counter:int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	counter += 1
	if counter >= 180:
		queue_free()


func _on_area_3d_body_entered(body):
	body.health -= 10
	queue_free()
