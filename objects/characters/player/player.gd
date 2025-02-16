# Player.gd
class_name Player
extends CharacterBody2D

@onready var animplayer = $CharacterSETUP/body/AnimationPlayer
@onready var spritenode = $CharacterSETUP

@export var speed: float = 200

var using_item: bool = false

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	
	if direction.x < 0:
		spritenode.scale.x = -1
	elif direction.x > 0:
		spritenode.scale.x = 1
	
	if direction != Vector2.ZERO:
		if !using_item:
			animplayer.play("runPLAYER")
		velocity = direction * speed
	else:
		if !using_item:
			animplayer.play("idlePLAYER")
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		if PlayerData.holding_item.type == 1:
			using_item = true
			match PlayerData.holding_item.name:
				"Hoe":
					animplayer.play("hoe")
				"Saw":
					animplayer.play("saw")
				"Axe":
					animplayer.play("chop")
			await animplayer.animation_finished
			using_item = false

func collect(item: InvItem):
	PlayerData.Inventory.insert(item)
