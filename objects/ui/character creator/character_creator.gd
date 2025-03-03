# CharacterCreator.gd

extends Control

# Change Scene
func _on_confirm_pressed() -> void:
	$SelectSFX.play()
	get_tree().change_scene_to_file("res://exterior_world.tscn")
