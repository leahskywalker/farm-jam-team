extends CanvasModulate

func _process(_delta):
	var DNManager = DayAndNightCycleManager
	var light = DNManager.day_progression*2
	color.v = pingpong(light, 1.0)
