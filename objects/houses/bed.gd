# Bed.gd
extends Area2D

# Connect body_entered and body_exited signals
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.connect("interact", Callable(self, "_on_interact"))

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.disconnect("interact", Callable(self, "_on_interact"))

func _on_interact() -> void:
	# Call the function to skip time to 6 AM the next day
	DayAndNightCycleManager.skip_to_next_morning()
	print("You slept until 6 AM the next day.")
