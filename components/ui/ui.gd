extends Control

var data: PlanetDataCollector = preload("res://components/default-planet-rs.tres")

@onready var noise := $panel/hbox/noise
@onready var resolution := $panel/hbox/resolution/LineEdit
@export var plannet: Planet
var radius := 20

var noise_ui_scean := preload("res://components/noise-layer-ui/noise_layer_ui.tscn")

func  _ready() -> void:
	resolution.text = str(data.resolution)
	_update()

func _update() -> void:
	plannet.data = data
	plannet.on_data_change()

# resolution
func _on_line_edit_text_changed(new_text: String) -> void:
	if float(new_text):
		data.resolution = int(new_text)
