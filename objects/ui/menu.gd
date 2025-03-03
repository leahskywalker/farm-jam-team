extends Button

func _ready() -> void:
	%Menu.pressed.connect(go_to)

func go_to():
	$ButtonSFX.play()
	get_tree().change_scene_to_file("res://objects/ui/main_menu.tscn")
