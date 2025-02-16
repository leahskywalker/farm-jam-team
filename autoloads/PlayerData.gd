extends Node

var Inventory: Inv = Inv.new()
var holding_item: InvItem = null

const InventorySize: int = 36

var PlayerNode: Node2D

func _ready() -> void:
	Inventory.insert(load("res://objects/ui/inventory/inventory items/Hoe.tres"))
