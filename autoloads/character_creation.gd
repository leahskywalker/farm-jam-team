# CharacterCreation.gd

extends Node

# Shirt Sprite Sheet
var shirt_sprites = preload("res://assets/sprites/game/characters/shirts.png")
var shirt_hframes = 9

# Mouth Sprite Sheet
var mouth_sprites = preload("res://assets/sprites/game/characters/mouths.png")
var mouth_hframes = 5

# Facial Hair Sprite Sheet
var facial_hair_sprites = preload("res://assets/sprites/game/characters/mouthHair.png")
var facial_hair_hframes = 4

# Eye Sprite Sheet
var eye_sprites = preload("res://assets/sprites/game/characters/eyes.png")
var eye_hframes = 5

# Hair Sprite Sheet
var hair_sprites = preload("res://assets/sprites/game/characters/hair.png")
var hair_hframes = 13

# Selected Values
var selected_shirt: int = 0
var selected_mouth: int = 0
var selected_facial_hair: int = 0
var selected_eyes: int = 0
var selected_hair: int = 0
# Selected Colors
var selected_shirt_color: Color = Color.SKY_BLUE
var selected_facial_hair_color: Color = Color.SIENNA
var selected_hair_color: Color = Color.SIENNA
var selected_skin_color: Color = Color.MISTY_ROSE
