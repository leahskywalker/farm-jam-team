extends Node2D

@onready var croplayer: TileMapLayer = $Croplayer
@onready var soil_layer: TileMapLayer = $SoilLayer

#Things to add:
#1. Valid placement locations (needs tiles)
#2. Plant time processing (requires...the rest)

func _unhandled_input(_event):
	var pos = soil_layer.local_to_map(get_local_mouse_position())
	if Input.is_action_just_pressed("till"):
		if soil_layer.get_used_cells().has(pos):
			return
		soil_layer.set_cell(pos, 0, Vector2i(1,0))
	
	if Input.is_action_just_pressed("plant"):
		if croplayer.get_used_cells().has(pos) or !soil_layer.get_used_cells().has(pos):
			return
		croplayer.set_cell(pos , 1, Vector2i(0, 0), 1)

func _process(delta):
	for c in croplayer.get_children():
		if c.GrowTime > 0:
			c.GrowTime -= delta
