# Door.gd
extends Area2D

# Export Var to Get Target Scene Path
@export var target_scene: String = ""

@onready var interactable_component: Area2D = $"."
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool

# Signals to Show or Hide Label
signal interactable_activated
signal interactable_deactivated

# Connect body_entered and body_exited Signals
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	connect("interactable_activated", Callable(self, "on_interactable_activated"))
	connect("interactable_deactivated", Callable(self, "on_interactable_deactivated"))
	interactable_label_component.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.connect("interact", Callable(self, "_on_interact"))
		interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.disconnect("interact", Callable(self, "_on_interact"))
		interactable_deactivated.emit()

func _on_interact():
	if target_scene != "":
		get_tree().change_scene_to_file(target_scene)
	else:
		print("No target scene specified for the door.")

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false
