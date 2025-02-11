extends Node

var Inventory: Inv = Inv.new()

const InventorySize: int = 32

#Add additional player data here

func _ready() -> void:
	Inventory.insert(load("res://objects/ui/inventory/inventory items/Hoe.tres"))
