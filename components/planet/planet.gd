@tool
extends Node3D
class_name Planet

@export var data: PlanetDataCollector:
	set(val):
		data = val
		if data != null and not data.is_connected("changed", on_data_change):
			data.connect("changed", on_data_change)

func _ready() -> void:
	on_data_change()

func on_data_change()-> void:
	if data != null:
		data.max_h = -9999
		data.min_h = 9999
		for child in get_children():
			var face := child as PlanetMeshFace
			face.generate(data)

func merge():
	if data != null:
		var mesh := Mesh.new()
		for child in get_children():
			var face := child as PlanetMeshFace
			face.mesh.ARRAY_VERTEX
