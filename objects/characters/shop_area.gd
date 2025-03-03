extends Area2D

@onready var shop = $CanvasLayer/Shop

func _process(delta):
	if Input.is_action_just_pressed("interact") and has_overlapping_bodies():
		shop.visible = !shop.visible
