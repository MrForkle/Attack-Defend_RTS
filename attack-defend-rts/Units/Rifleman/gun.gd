extends Node3D

var bullet := preload("res://Units/Bullet/bullet.tscn")

var shooting := false
var looks_at = null
var look_at_position = null
var can_shoot_at = []
var cycle :int = 0

func _process(_delta: float) -> void:
	if look_at_position != null:
		look_at(look_at_position)

func shoot_bullet():
	var bullet_instantiated := bullet.instantiate()
	bullet_instantiated.position = $"Bullet Spawn Point".global_position
	bullet_instantiated.apply_central_force(to_global(position+Vector3(0,0,-4000))-global_position)
	get_tree().get_root().add_child(bullet_instantiated)
	

func update_aiming():
	
	can_shoot_at = []
	
	var in_range = get_parent().get_node("Detection Range").get_overlapping_bodies()
	
	for i in in_range:
		var space = get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.collision_mask = 16384
		ray_query.from = global_position
		ray_query.to = i.global_position
		var raycast_result = space.intersect_ray(ray_query)
		if raycast_result.is_empty():
			pass
		elif instance_from_id(raycast_result['collider_id']) == i:
			can_shoot_at.append(i)
	if !can_shoot_at.is_empty():
		looks_at = randi_range(0,len(can_shoot_at)-1)
		shooting = true
		look_at_position = can_shoot_at[looks_at].global_position
		get_parent().look_at(look_at_position)
		look_at(look_at_position)
		return
	look_at_position = null
	shooting = false

func _on_timer_timeout() -> void:
	if shooting == true:
		shoot_bullet()

func _on_detection_range_body_entered(_body: Node3D) -> void:
	update_aiming()

func _on_detection_range_body_exited(_body: Node3D) -> void:
	update_aiming()

func _on_re_aim_timer_timeout() -> void:
	if shooting != true:
		update_aiming()
