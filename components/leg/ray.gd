extends RayCast3D

@export var target : Node3D

func _process(delta: float) -> void:
	target.global_position = get_collision_point()
