extends Node

var Inventory: Inv = Inv.new()
var holding_item: InvItem = null

const InventorySize: int = 36
var PlayerMoney: int = 100

# Node Ref
@onready var shirt: Sprite2D = $Skeleton/body/Shirt/shirt
@onready var head: Sprite2D = $Skeleton/body/Head/head
@onready var mouth: Node2D = $Skeleton/body/Head/head/Mouth
@onready var facial_hair: Node2D = $Skeleton/body/Head/head/FacialHair
@onready var hair: Node2D = $Skeleton/body/Head/head/Hair
@onready var eyes: Node2D = $Skeleton/body/Head/head/Eyes

var PlayerNode: Node2D

var DarkTimer: float = 15.0
var in_dark: bool = false

func _ready() -> void:
	Inventory.insert(load("res://objects/ui/inventory/inventory items/Hoe.tres"))

func initialize_player() -> void:
	# Shirt and Color
	shirt.texture = CharacterCreation.shirt_sprites[CharacterCreation.selected_shirt]
	shirt.modulate = CharacterCreation.selected_shirt_color
	
	# Mouth
	mouth.texture = CharacterCreation.mouth_sprites[CharacterCreation.selected_mouth]
	
	# Facial Hair and Color
	facial_hair.texture = CharacterCreation.facial_hair_sprites[CharacterCreation.selected_facial_hair]
	facial_hair.modulate = CharacterCreation.selected_facial_hair_color
	
	# Eyes
	eyes.texture = CharacterCreation.eye_sprites[CharacterCreation.selected_eyes]
	
	# Hair and Color
	hair.texture = CharacterCreation.hair_sprites[CharacterCreation.selected_hair]
	hair.modulate = CharacterCreation.selected_hair_color

func _process(delta):
	print("in dark :"+str(in_dark))
	if in_dark and DayAndNightCycleManager.day_progression > 0.7:
		DarkTimer -= delta
		if DarkTimer <= 0:
			print("Stayed in dark for too long")
	else:
		DarkTimer = 15.0
