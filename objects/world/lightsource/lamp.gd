extends Node2D

@onready var area = $Area2D

func _process(delta):
	if area.has_overlapping_bodies():
		PlayerData.in_dark = false

func _on_area_2d_body_exited(body):
	PlayerData.in_dark = true
