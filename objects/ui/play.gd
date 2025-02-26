extends Button

func _ready() -> void:
	%Play.pressed.connect(play)

func play():
	get_tree().change_scene_to_file("res://objects/ui/character creator/character_creator.tscn")
