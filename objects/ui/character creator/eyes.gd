# Eyes.gd
extends Node2D

# Node Ref
@onready var eye_sprite: Sprite2D = $eyes

# Current Frame Index
var current_eye_index = 0

func _ready() -> void:
	update_sprite()

# Update Texture & Frame
func update_sprite():
	eye_sprite.texture = CharacterCreation.eye_sprites
	eye_sprite.hframes = CharacterCreation.eye_hframes
	eye_sprite.frame = current_eye_index
	
	CharacterCreation.selected_eyes = current_eye_index

# Change Eyes Left
func _on_left_pressed() -> void:
	if current_eye_index == 0:
		current_eye_index = CharacterCreation.eye_hframes - 1
	else:
		current_eye_index = (current_eye_index - 1) % (CharacterCreation.eye_hframes)
	update_sprite()

# Change Eyes Right
func _on_right_pressed() -> void:
	current_eye_index = (current_eye_index + 1) % (CharacterCreation.eye_hframes)
	update_sprite()
