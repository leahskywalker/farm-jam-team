extends CanvasModulate
var DNManager = DayAndNightCycleManager
var time : float
var day_length : float = DNManager.DUSK_TIME - DNManager.DAWN_TIME
var midday : float = DNManager.DAWN_TIME + (day_length)/2 

func _process(_delta):
	time = DNManager.day_progression
	
	color.v = get_brightness()
	color.s = get_hue()
	await get_tree().create_timer(3.0).timeout
	
	#var DNManager = DayAndNightCycleManager
	#var light = DNManager.day_progression*2
	#color.v = pingpong(log(light), 1.0)

func get_brightness():
	var bright :float = 1.5*(cos((time-midday)*TAU))+2.0*day_length
	print(str(time) + "brightness is "+str(bright))
	return max(min(bright,1.0), 0.0)

	
func get_hue():
	var sine : float = sin((time-midday)*TAU)
	#var hue : float = 3.0*(sine*sine)-2.5
	var hue : float = 0.6-abs(get_brightness()-0.4)
	print(str(time) + "hue is "+str(hue))
	return max(min(hue,0.6),0.0)
