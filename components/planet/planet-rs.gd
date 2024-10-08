@tool
extends Resource
class_name PlanetDataCollector

@export var texture : GradientTexture1D:
	set(val):
		texture = val
		emit_signal("changed")

@export var radius : float = 1:
	set(val):
		radius = val
		emit_signal("changed")
@export var resolution: int = 10:
	set(val):
		resolution = val
		emit_signal("changed")
@export var noise_layer: Array[PlanetData]:
	set(val):
		noise_layer = val
		for d in noise_layer:
			if d != null and not d.is_connected("changed", on_data_change):
				d.connect("changed", on_data_change)

var max_h: float = -9999
var min_h: float = 9999

func on_data_change() -> void:
	emit_signal("changed")

func point_on_planet(point: Vector3) -> Vector3:
	var elevesion := 0.0
	for c in noise_layer:
		if c != null and c.noise != null:
			var l_elevesion := c.noise.get_noise_3dv(point) * c.noise_gain
			l_elevesion = (c.noise.get_noise_3dv(point) * c.noise_gain + 1) / 2.0
			l_elevesion = max(0.0, l_elevesion - c.min_height)
			elevesion += l_elevesion
	return point * (elevesion + 1) * radius
