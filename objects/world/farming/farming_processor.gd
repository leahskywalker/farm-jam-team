extends Node2D

@onready var croplayer: TileMapLayer = $Croplayer
@onready var soil_layer: TileMapLayer = $SoilLayer

var day_progress: float
var last_progress: float

func _ready():
	#connect the time signal here (0.0f to 1.0f)
	DayAndNightCycleManager.game_day_progression.connect(check_time)

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
	var time_passed = (day_progress-last_progress)
	for c in croplayer.get_children():
		if c.GrowTime > 0:
			c.GrowTime -= (time_passed)
	last_progress = day_progress

func till_ground(pos: Vector2i):
	soil_layer.set_cell(pos, 0, Vector2i(0,0))

func check_time(day_progression):
	day_progress = day_progression
	
