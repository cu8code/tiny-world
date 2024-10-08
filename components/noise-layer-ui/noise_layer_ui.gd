extends VBoxContainer
class_name NoiseLayerUi

signal changed

var id: int
var data = {
	"gain" : 0.1,
	"seed": 0,
	"frequency": 0.9
}

@onready var gain := $gain/LineEdit
@onready var seed := $seed/LineEdit
@onready var frequency := $frequency/LineEdit

func setup(gain, seed, frequency, id) -> void:
	data["gain"] = float(gain)
	data["seed"] = float(seed)
	data["frequency"] = float(frequency)
	self.id = id

func _ready() -> void:
	_update()

func _update() -> void:
	gain.text = str(data["gain"])
	seed.text = str(data["seed"])
	frequency.text = str(data["frequency"])

func _on_gain_change(new_text: String) -> void:
	data["gain"] = float(new_text)
	emit_signal("changed", data, id)

func _on_seed_changed(new_text: String) -> void:
	data["seed"] = float(new_text)
	emit_signal("changed", data, id)

func _on_frequency_changed(new_text: String) -> void:
	data["frequency"] = float(new_text)
	emit_signal("changed", data, id)
