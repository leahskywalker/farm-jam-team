# InvUI.gd
extends NinePatchRect

@onready var inv
@onready var slots: Array = $InvPanel/MarginContainer/GridContainer.get_children()


var is_open = false

func _ready():
	inv = PlayerData.Inventory
	inv.update.connect(update_slots)
	update_slots()
	close()
	
	# Connect the gui_input signal for each slot
	for slot in slots:
		slot.connect("gui_input", Callable(self, "_on_slot_gui_input"))

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Check if the click is within the bounds of any slot
			for i in range(slots.size()):
				var slot = slots[i]
				if slot.get_global_rect().has_point(event.global_position):
					# Update the selected item in PlayerData
					PlayerData.holding_item = inv.slots[i].item
					print("Selected item in inventory: ", PlayerData.holding_item.name if PlayerData.holding_item else "null")
					update_slots()  # Refresh the inventory UI to highlight the selected slot
					break  # Stop checking after the first matching slot
