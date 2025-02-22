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
var selected_shirt = ""
var selected_mouth = ""
var selected_facial_hair = ""
var selected_eyes = ""
var selected_hair = ""
# Selected Colors
var selected_shirt_color = ""
var selected_facial_hair_color = ""
var selected_hair_color = ""
