# InventoryItem.gd
class_name InvItem
extends Resource

@export var name: String = ""
@export_enum("CROP", "TOOL") var type: int = 0
@export var texture: Texture2D
