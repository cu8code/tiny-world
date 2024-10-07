extends Node3D

var dir: Vector3
var speed : float = 1.0
var rspeed: float = 1.0

func _process(delta: float) -> void:
	dir.x = -Input.get_axis("move_forward", "move_backward")
	translate(Vector3(dir.x, 0, 0) * speed * delta)
