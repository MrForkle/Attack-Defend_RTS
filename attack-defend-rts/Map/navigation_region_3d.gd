extends NavigationRegion3D

func _on_navigation_mesh_changed() -> void:
	bake_navigation_mesh()
