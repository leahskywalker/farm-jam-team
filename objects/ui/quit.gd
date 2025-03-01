extends Button


func _ready() -> void:
	%Quit.pressed.connect(press)

func press():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
