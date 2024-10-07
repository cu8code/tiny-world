@tool
extends Resource
class_name PlanetData

@export var noise_gain : float = 1:
	set(val):
		noise_gain = val
		emit_signal("changed")
@export var min_height : float = 1:
	set(val):
		min_height = val
		emit_signal("changed")
@export var noise: FastNoiseLite:
	set(val):
		noise = val
		emit_signal("changed")
		if noise != null and not noise.is_connected("changed", on_data_change):
			noise.connect("changed", on_data_change)

func on_data_change() -> void:
	emit_signal("changed")
