#  Hair.gd
extends Node2D

# Node Ref
@onready var hair_sprite: Sprite2D = $hair 

# Current Frame Index
var current_hair_index = 0
# Color Replacement Accuracy
var precision : float = 1.5

# Preload Shader & Set oldColor
func _ready() -> void:
	if hair_sprite.material == null:
		hair_sprite.material = ShaderMaterial.new()
		hair_sprite.material.shader = preload("res://objects/ui/character creator/character_creator_shader.gdshader")
	
	var sampled_color = Color(250/255.0, 247/255.0, 250/255.0, 1.0)
	hair_sprite.material.set_shader_parameter("oldColor", sampled_color)
	
	hair_sprite.material.set_shader_parameter("precision", precision)
	
	update_sprite()

# Update Texture & Frame
func update_sprite():
	hair_sprite.texture = CharacterCreation.hair_sprites
	hair_sprite.hframes = CharacterCreation.hair_hframes
	hair_sprite.frame = current_hair_index
	
	CharacterCreation.selected_hair = current_hair_index

# Change Hair Left
func _on_left_pressed() -> void:
	current_hair_index = wrapi(current_hair_index-1, 0, CharacterCreation.hair_hframes)
	update_sprite()

# Change Hair Right
func _on_right_pressed() -> void:
	current_hair_index = wrapi(current_hair_index+1, 0, CharacterCreation.hair_hframes)
	update_sprite()

# Change Hair Color
func _on_hair_color_picker_button_color_changed(color: Color) -> void:
	if hair_sprite.material:
		hair_sprite.material.set_shader_parameter("newColor", color)
	CharacterCreation.selected_hair_color = color
