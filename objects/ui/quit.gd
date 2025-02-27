extends Button


func _ready() -> void:
	%Play.pressed.connect(press)

func press():
	#get_tree().quit()
	pass
