extends Node2D
class_name Crop

@onready var sprite = $Sprite

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
