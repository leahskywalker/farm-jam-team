# Door.gd
extends Area2D

# Export Var to Get Target Scene Path
@export var target_scene: String = ""

# Connect body_entered and body_exited Signals
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.connect("interact", Callable(self, "_on_interact"))


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.disconnect("interact", Callable(self, "_on_interact"))

func _on_interact():
	if target_scene != "":
		get_tree().change_scene_to_file(target_scene)
	else:
		print("No target scene specified for the door.")
