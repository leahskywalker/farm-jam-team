extends Control

@onready var slots = {
	1: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot, 
	2: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot2, 
	3: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot3, 
	4: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot4, 
	5: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot5, 
	6: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot6, 
	7: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot7, 
	8: $PanelContainer/MarginContainer/HotbarSlots/HotbarUISlot8
}

var slotcount: int = 8

func _ready():
	update()

func update() -> void:
	for n in range(slotcount):
		var item = PlayerData.Inventory.slots[n].item
		var slot = slots.get(n+1)
		if item:
			slot.item_visual.texture = item.texture
