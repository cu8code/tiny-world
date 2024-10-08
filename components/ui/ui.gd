extends Control

var data: PlanetDataCollector = preload("res://pages/game.tres")

@onready var noise := $panel/hbox/noise
@onready var resolution := $panel/hbox/resolution/LineEdit
@export var plannet: Planet
var radius := 20

var noise_ui_scean := preload("res://components/noise-layer-ui/noise_layer_ui.tscn")

func  _ready() -> void:
	resolution.text = str(data.resolution)
	for x in len(data.noise_layer):
		var d = data.noise_layer[x]
		var new_noise_layer_ui: NoiseLayerUi = noise_ui_scean.instantiate()
		new_noise_layer_ui.setup(d.noise_gain, d.noise.seed, d.noise.frequency, x)
		new_noise_layer_ui.connect("changed", on_changed_noise_ui)
		noise.add_child(new_noise_layer_ui)
	_update()
	print(data.noise_layer)

func _update() -> void:
	plannet.data = data
	plannet.on_data_change()

# resolution
func _on_line_edit_text_changed(new_text: String) -> void:
	if float(new_text):
		data.resolution = int(new_text)

func on_changed_noise_ui(data, id):
	var n : PlanetData = self.data.noise_layer[id]
	n.noise.frequency = data["frequency"]
	n.noise.seed = data["seed"]
	n.noise_gain = data["gain"]
	_update()

func _on_new_pressed() -> void:
	var simplex_noise := FastNoiseLite.new()
	var some_data := PlanetData.new()
	some_data.noise = simplex_noise
	self.data.noise_layer.push_back(some_data)
	var new_noise_layer_ui: NoiseLayerUi = noise_ui_scean.instantiate()
	new_noise_layer_ui.setup(1, 0, .2, len(self.data.noise_layer))
	new_noise_layer_ui.connect("changed", on_changed_noise_ui)
	noise.add_child(new_noise_layer_ui)
