extends Node

var Inventory: Inv = Inv.new()
var holding_item = null

const InventorySize: int = 36

#Add additional player data here

func _ready() -> void:
	Inventory.insert(load("res://objects/ui/inventory/inventory items/Hoe.tres"))
