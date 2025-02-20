# Head.gd
extends Node2D

# Node Ref
@onready var head_sprite: Sprite2D = $head

# Color Replacement Accuracy
var precision : float = 1.5

# Preload Shader & Set oldColor
func _ready() -> void:
	if head_sprite.material == null:
		head_sprite.material = ShaderMaterial.new()
		head_sprite.material.shader = preload("res://objects/ui/character creator/character_creator_shader.gdshader")
	
	var sampled_color = Color(250/255.0, 247/255.0, 250/255.0, 1.0)
	head_sprite.material.set_shader_parameter("oldColor", sampled_color)
	
	head_sprite.material.set_shader_parameter("precision", precision)

# Change Skin Color
func _on_skin_color_picker_button_color_changed(color: Color) -> void:
	if head_sprite.material:
		head_sprite.material.set_shader_parameter("newColor", color)
