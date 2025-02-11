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
