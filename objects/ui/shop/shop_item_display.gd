extends Control

@export var Items: Dictionary = {
	1: preload("res://objects/ui/inventory/inventory items/carrot_item.tres"),
	2: null,
	3: null,
	4: null,
	5: null,
	6: null,
	7: null,
	8: null,
	9: null
}

func _ready():
	for I in Items.keys():
		var itemtex = Items.get(I).texture
		var button = find_child("TextureButton"+str(I))
		button.texture = itemtex

func buy_item(index: int) -> void:
	var item_bought: InvItem = Items[index]
	if item_bought and item_bought.Cost <= PlayerData.PlayerMoney:
		PlayerData.PlayerMoney -= item_bought.Cost
		PlayerData.Inventory.insert(item_bought)
