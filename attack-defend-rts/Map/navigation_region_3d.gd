extends NavigationRegion3D

func _ready() -> void:
	bake_navigation_mesh()

func _on_bake_finished() -> void:
	bake_navigation_mesh()
