# Shirt.gd
extends Node2D

# Node Ref
@onready var shirt_sprite: Sprite2D = $shirt
@onready var animplayer: AnimationPlayer = $"../AnimationPlayer"

# Current Frame Index
var current_shirt_index = 0
# Color Replacement Accuracy
var precision : float = 1.5

# Preload Shader & Set oldColor
func _ready() -> void:
	if shirt_sprite.material == null:
		shirt_sprite.material = ShaderMaterial.new()
		shirt_sprite.material.shader = preload("res://objects/ui/character creator/character_creator_shader.gdshader")
	
	var sampled_color = Color(250/255.0, 247/255.0, 250/255.0, 1.0)
	shirt_sprite.material.set_shader_parameter("oldColor", sampled_color)
	
	shirt_sprite.material.set_shader_parameter("precision", precision)
	
	update_sprite()
	animplayer.play("idlePLAYER")

# Update Texture & Frame
func update_sprite():
	shirt_sprite.texture = CharacterCreation.shirt_sprites
	shirt_sprite.hframes = CharacterCreation.shirt_hframes
	shirt_sprite.frame = current_shirt_index
	
	CharacterCreation.selected_shirt = current_shirt_index

# Change Shirt Left
func _on_left_pressed() -> void:
	if current_shirt_index == 0:
		current_shirt_index = CharacterCreation.shirt_hframes - 1
	else:
		current_shirt_index = (current_shirt_index - 1) % (CharacterCreation.shirt_hframes)
	update_sprite()

# Change Shirt Right
func _on_right_pressed() -> void:
	current_shirt_index = (current_shirt_index + 1) % (CharacterCreation.shirt_hframes)
	update_sprite()

# Change Shirt Color
func _on_shirt_color_picker_button_color_changed(color: Color) -> void:
	if shirt_sprite.material:
		shirt_sprite.material.set_shader_parameter("newColor", color)
