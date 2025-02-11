extends Control

const INVENTORY_SLOT = preload("res://objects/ui/inventory/inventory display/InventorySlot.tscn")

var texture_slots: Array[Control] = []

@onready var grid = $GridContainer

func _ready():
	for i in range(PlayerData.InventorySize):
		var islot = INVENTORY_SLOT.instantiate()
		islot.name = str(i)
		grid.add_child(islot)
		texture_slots.append(islot.get_child(0))
	update_display()

func update_display() -> void:
	for slot in range(PlayerData.InventorySize):
		var item = PlayerData.Inventory.slots[slot].item as InvItem
		var matched_slot = texture_slots[slot] as TextureRect
		if item == null or matched_slot == null:
			continue
		matched_slot.texture = item.texture
