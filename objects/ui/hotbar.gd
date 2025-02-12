extends Control

@onready var inv
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
	# Connect the gui_input signal for each slot
	for slot in slots.values():
		slot.gui_input.connect(_input)

func update() -> void:
	for n in range(slotcount):
		var item = PlayerData.Inventory.slots[n].item
		var slot = slots.get(n+1)
		if item:
			slot.item_visual.texture = item.texture

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Check if the click is within the bounds of any slot
			for i in range(1, slotcount + 1):
				var slot = slots.get(i)
				if slot._has_point(event.global_position):
					# Update the selected item in PlayerData
					PlayerData.holding_item = PlayerData.Inventory.slots[i - 1].item
					update_selected_slot(i - 1)
					break  # Stop checking after the first matching slot


func update_selected_slot(selected_slot_index: int) -> void:
	for n in range(slotcount):
		var slot = slots.get(n+1)
