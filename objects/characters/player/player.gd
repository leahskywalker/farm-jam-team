# Player.gd
class_name Player
extends CharacterBody2D

@onready var animplayer = $CharacterSETUP/body/AnimationPlayer
@onready var spritenode = $CharacterSETUP

@export var speed: float = 200
@export var inv: Inv

func _physics_process(_delta: float) -> void:
	var direction = GameInputEvent.movement_input()
	
	if direction.x < 0:
		spritenode.scale.x = -1
	elif direction > 0:
		spritenode.scale.x = 1
	
	if direction != Vector2.ZERO:
		animplayer.play("runPLAYER")
		velocity = direction * speed
	else:
		animplayer.play("idlePLAYER")
		velocity = Vector2.ZERO
	
	move_and_slide()

func collect(item):
	inv.insert(item)
