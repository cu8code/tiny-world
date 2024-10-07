extends Node3D

var dir: Vector3
var speed : float = 1.0
var rspeed: float = 1.0

@export var skeleton : SkeletonIK3D

func _ready() -> void:
	skeleton.start()
