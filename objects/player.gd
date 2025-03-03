# Player.gd
class_name Player
extends CharacterBody2D

@onready var animplayer = $CharacterSETUP/body/AnimationPlayer
@onready var spritenode = $CharacterSETUP

@onready var shirt = $CharacterSETUP/body/shirt
@onready var mouth = $CharacterSETUP/body/head/mouth
@onready var eyes = $CharacterSETUP/body/head/eyes
@onready var facial_hair = $CharacterSETUP/body/head/facialHAIR
@onready var hair = $CharacterSETUP/body/head/hair
@onready var head = $CharacterSETUP/body/head

@export var speed: float = 400

var using_item: bool = false
var in_bed_area = false

signal interact
signal sleep

func _ready():
	PlayerData.PlayerNode = self
	PlayerData.initialize_player()
	add_to_group("player")

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
	
	if Input.is_action_just_pressed("hit"):
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

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("sleep"):
		emit_signal("sleep")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("interact")
		
	if event.is_action_pressed("sleep"):
		go_to_sleep()

func go_to_sleep() -> void:
	DayAndNightCycleManager.skip_to_next_morning()
	print("You sleep until 6 AM the next day")
