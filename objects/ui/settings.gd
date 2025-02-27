extends Button

func _ready() -> void:
	%Settings.pressed.connect(go_to)

func go_to():
	get_tree().change_scene_to_file("res://objects/ui/settings.tscn")
