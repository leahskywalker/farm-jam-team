extends SpinBox
var bus_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value_changed.connect(change_value)
	bus_index = AudioServer.get_bus_index("SFX")
	value = 100 * db_to_linear(AudioServer.get_bus_volume_db(bus_index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func change_value(value):
	#print("value : "+str(value))
	AudioServer.set_bus_volume_db(bus_index,linear_to_db(value/100))
