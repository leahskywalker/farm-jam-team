# Inventory.gd
class_name Inv
extends Resource

signal update

@export var slots: Array[InvSlot]

func _init():
	slots.resize(PlayerData.InventorySize)
	for n in range(slots.size()):
		slots[n] = InvSlot.new()

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
