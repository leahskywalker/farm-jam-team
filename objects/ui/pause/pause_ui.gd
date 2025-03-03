# PauseUI.gd
extends NinePatchRect

var is_open = false

func _ready():
	close_pause()


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if is_open:
			close_pause()
			get_tree().paused = false
		else:
			open_pause()
			get_tree().paused = true

func open_pause():
	visible = true
	is_open = true

func close_pause():
	visible = false
	is_open = false


func _on_back_pressed() -> void:
	close_pause()
