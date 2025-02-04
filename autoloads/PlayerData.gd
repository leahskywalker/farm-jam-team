extends Node

var Inventory: Dictionary = {}

const InventorySize: int = 36

#Add additional player data here

func _ready() -> void:
	#Sets up inventory slots
	inventory_setup()
	print(Inventory)

func inventory_setup() -> void: 
	for i in range(InventorySize):
		#for each number from 0 to InventorySize, add a "slot", an int we can reference to fetch a slot
		Inventory[i] = null
