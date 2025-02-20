# FacialHair.gd
extends Node2D

# Node Ref
@onready var facial_hair_sprite: Sprite2D = $facialHAIR

# Current Frame Index
var current_facial_hair_index = 0

# Color Replacement Accuracy
var precision : float = 1.5

# Preload Shader & Set oldColor
func _ready() -> void:
	if facial_hair_sprite.material == null:
		facial_hair_sprite.material = ShaderMaterial.new()
		facial_hair_sprite.material.shader = preload("res://objects/ui/character creator/character_creator_shader.gdshader")
	
	var sampled_color = Color(250/255.0, 247/255.0, 250/255.0, 1.0)
	facial_hair_sprite.material.set_shader_parameter("oldColor", sampled_color)
	
	facial_hair_sprite.material.set_shader_parameter("precision", precision)
	
	update_sprite()

# Update Texture & Frame
func update_sprite():
	if current_facial_hair_index == 0:
		facial_hair_sprite.texture = null
		facial_hair_sprite.hframes = 1
		facial_hair_sprite.frame = 0
	else:
		facial_hair_sprite.texture = CharacterCreation.facial_hair_sprites["01"]
		facial_hair_sprite.hframes = CharacterCreation.facial_hair_hframes
		facial_hair_sprite.frame = current_facial_hair_index - 1
	
	CharacterCreation.selected_facial_hair = current_facial_hair_index

# Change Shirt Left
func _on_left_pressed() -> void:
	if current_facial_hair_index == 0:
		current_facial_hair_index = 2
	else:
		current_facial_hair_index = (current_facial_hair_index - 1 + 3) % 3
	update_sprite()

# Change Shirt Right
func _on_right_pressed() -> void:
	current_facial_hair_index = (current_facial_hair_index + 1) % 3
	update_sprite()

# Change Shirt Color
func _on_facial_hair_color_picker_button_color_changed(color: Color) -> void:
	if facial_hair_sprite.material:
		facial_hair_sprite.material.set_shader_parameter("newColor", color)
