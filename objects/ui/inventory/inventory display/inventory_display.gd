extends Control

const INVENTORY_SLOT = preload("res://objects/ui/inventory/inventory display/InventorySlot.tscn")
const CARROT_ITEM = preload("res://objects/ui/inventory/inventory items/carrot_item.tres")

var texture_slots: Array[Control] = []

@onready var grid = $GridContainer

func _ready():
	for i in range(PlayerData.InventorySize):
		var islot = INVENTORY_SLOT.instantiate()
		islot.name = str(i)
		grid.add_child(islot)
		texture_slots.append(islot.get_child(0))

func update_display() -> void:
	for slot in range(PlayerData.InventorySize):
		var item = PlayerData.Inventory.get(slot) as InvItem
		var matched_slot = texture_slots[slot] as TextureRect
		if item == null or matched_slot == null:
			continue
		matched_slot.texture = item.texture

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		var rand_number = randi_range(0, PlayerData.InventorySize)
		PlayerData.Inventory[rand_number] = CARROT_ITEM
		update_display()
