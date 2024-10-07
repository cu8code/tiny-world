extends Node3D

@export var target: Node3D
@export var distance: float = 3
@export var animation_duration: float = 1
@export var adjacent: Node3D

@export var is_moving: bool = false

func _process(delta: float) -> void:
	if abs(global_position.distance_to(target.global_position)) > distance and !is_moving:
		step()

func step() -> void:
	is_moving = true
	var half := (global_position + target.global_position) / 2
	var tween := get_tree().create_tween()
	tween.tween_property(self, "global_position", half + (owner.basis.y * 2.5), animation_duration)
	tween.tween_property(self, "global_position", target.global_position, animation_duration)
	tween.connect("finished", _on_tween_finished)

func _on_tween_finished() -> void:
	adjacent.is_moving = false
