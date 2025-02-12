# InvUISlot.gd
class_name UISlot
extends Panel

@onready var item_visual: TextureRect = $PanelContainer/ItemDisplay
@onready var amount_text: Label = $PanelContainer/Label

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)

func get_slot_index() -> int:
	# Return the index of this slot in the hotbar
	return get_parent().get_children().find(self)
