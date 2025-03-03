extends Node2D

@onready var croplayer: TileMapLayer = $Croplayer
@onready var soil_layer: TileMapLayer = $SoilLayer

var current_days: float
var last_days: float

func _ready():
	pass

func _unhandled_input(_event):
	var pos = croplayer.local_to_map((
			PlayerData.PlayerNode.global_position + PlayerData.PlayerNode.get_local_mouse_position()
			).clamp(
				PlayerData.PlayerNode.global_position+Vector2(-3,-3)*Vector2(croplayer.tile_set.tile_size),
				PlayerData.PlayerNode.global_position+Vector2(3,3)*Vector2(croplayer.tile_set.tile_size)
				))
	if Input.is_action_just_pressed("interact"):
		match PlayerData.holding_item.name:
			"Hoe":
				if croplayer.get_used_cells().has(pos):
					pass
				elif !soil_layer.get_used_cells().has(pos):
					till_ground(pos)
			"WaterBucket":
				print("Watering here: %s" % pos)
			

func _process(_delta):
	current_days = check_days()
	var time_passed = (current_days-last_days)
	for c in croplayer.get_children():
		if c.GrowTime > 0:
			c.GrowTime -= (time_passed)
	last_days = current_days

func till_ground(pos: Vector2i):
	soil_layer.set_cell(pos, 0, Vector2i(0,0))

func check_days()-> float:
	var days: float = DayAndNightCycleManager.days_passed_since_start(DayAndNightCycleManager.total_minutes(DayAndNightCycleManager.time))
	return days
