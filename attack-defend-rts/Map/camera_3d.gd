extends Camera3D

func shoot_ray(event):
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.collision_mask = 32768
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	
	if raycast_result.is_empty(): return
	
	if event == "Position": return raycast_result['position']
	
	if instance_from_id(raycast_result["collider_id"]).scene_file_path == 'res://Units/Rifleman/rifleman.tscn' and event == "Left":
		instance_from_id(raycast_result["collider_id"]).add_to_group("Selected")
	if event != "Right": return
	raycast_result['position'].y += 0.5
	for node in get_tree().get_nodes_in_group("Selected"):
		node.target_position = raycast_result['position']
		node.moving = true
		node.remove_from_group("Selected")
