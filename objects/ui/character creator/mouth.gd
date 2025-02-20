# Mouth.gd
extends Node2D

# Node Ref
@onready var mouth_sprite: Sprite2D = $mouth

# Current Frame Index
var current_mouth_index = 0

func _ready() -> void:
	update_sprite()

# Update Texture & Frame
func update_sprite():
	mouth_sprite.texture = CharacterCreation.mouth_sprites
	mouth_sprite.hframes = CharacterCreation.mouth_hframes
	mouth_sprite.frame = current_mouth_index
	
	CharacterCreation.selected_mouth = current_mouth_index

# Change Mouth Left
func _on_left_pressed() -> void:
	if current_mouth_index == 0:
		current_mouth_index = CharacterCreation.mouth_hframes - 1
	else:
		current_mouth_index = (current_mouth_index - 1) % (CharacterCreation.mouth_hframes)
	update_sprite()

# Change Mouth Right
func _on_right_pressed() -> void:
	current_mouth_index = (current_mouth_index + 1) % (CharacterCreation.mouth_hframes)
	update_sprite()
