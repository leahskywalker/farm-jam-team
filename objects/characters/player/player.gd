# Player.gd
class_name Player
extends CharacterBody2D

@export var speed: float = 200
@export var inv: Inv

func _physics_process(_delta: float) -> void:
	var direction = GameInputEvent.movement_input()
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func collect(item):
	inv.insert(item)
