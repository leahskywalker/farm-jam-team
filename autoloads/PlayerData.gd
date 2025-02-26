extends Node

var Inventory: Inv = Inv.new()
var holding_item: InvItem = null

const InventorySize: int = 36
var PlayerMoney: int = 100

# Node Ref
@onready var shirt: Sprite2D
@onready var head: Sprite2D
@onready var mouth: Node2D
@onready var facial_hair: Node2D
@onready var hair: Node2D
@onready var eyes: Node2D

var PlayerNode: Node2D

var DarkTimer: float = 15.0
var in_dark: bool = true

func _ready() -> void:
	Inventory.insert(load("res://objects/ui/inventory/inventory items/Hoe.tres"))

func initialize_player() -> void:
	shirt = PlayerNode.shirt
	# Shirt and Color
	shirt.frame = CharacterCreation.selected_shirt
	shirt.modulate = CharacterCreation.selected_shirt_color
	
	# Mouth
	mouth = PlayerNode.mouth
	
	mouth.frame = CharacterCreation.selected_mouth
	
	## Facial Hair and Color
	facial_hair = PlayerNode.facial_hair

	shirt.frame = CharacterCreation.selected_shirt
	shirt.modulate = CharacterCreation.selected_shirt_color
	
	## Eyes
	eyes = PlayerNode.eyes
	
	eyes.frame = CharacterCreation.selected_mouth
	
	## Hair and Color
	hair = PlayerNode.hair
	
	hair.frame = CharacterCreation.selected_shirt
	hair.modulate = CharacterCreation.selected_shirt_color

func _process(delta):
	if in_dark and (DayAndNightCycleManager.day_progression > 0.7 or DayAndNightCycleManager.day_progression < 0.4):
		DarkTimer -= delta
		if DarkTimer <= 0:
			print("Stayed in dark for too long")
	else:
		DarkTimer = 15.0
