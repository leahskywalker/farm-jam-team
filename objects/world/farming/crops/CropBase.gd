extends Node2D
class_name Crop

@onready var sprite = $Sprite

# Inventory Resource Type
@export var item: InvItem
var player_in_area = false
var player = null

##Type of Crop
@export var type: StringName = &""

##Time (in seconds) to growth complete
@export var MaxGrowTime: float = 10.0
@export var GrowTime: float = 10.0:
	set(value):
		GrowTime = value
		if GrowTime < MaxGrowTime*0.25:
			sprite.frame = 3
		elif GrowTime < MaxGrowTime*0.5:
			sprite.frame = 2
		elif GrowTime < MaxGrowTime*0.75:
			sprite.frame = 1

##Time planted
@export var PlantTime: float = 0.0

# Inventory Item Resource Collection
func _on_collectable_area_body_entered(body) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_collectable_area_body_exited(body) -> void:
	if body.has_method("player"):
		player_in_area = false

func get_item():
	player.collect(item)
