# Player.gd
class_name Player
extends CharacterBody2D

@onready var animplayer = $CharacterSETUP/body/AnimationPlayer
@onready var spritenode = $CharacterSETUP

@export var speed: float = 200

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("walk_left","walk_right","walk_up","walk_down")
	
	if direction.x < 0:
		spritenode.scale.x = -1
	elif direction.x > 0:
		spritenode.scale.x = 1
	
	if direction != Vector2.ZERO:
		animplayer.play("runPLAYER")
		velocity = direction * speed
	else:
		animplayer.play("idlePLAYER")
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		if PlayerData.holding_item.type == 1:
			match PlayerData.holding_item.name:
				"Hoe":
					animplayer.play("hoe")
	

func collect(item: InvItem):
	PlayerData.Inventory.insert(item)
