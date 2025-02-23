extends Node

const MORNINGSTARTTIME = 0.2
const DAYSTARTTIME = 0.5
const EVENINGSTARTTIME = 0.7
const NIGHTSTARTTIME = 0.9

var music

var lasttime = 0
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	music = get_node("music")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var DNManager = DayAndNightCycleManager
	lasttime = time
	time = DNManager.day_progression
	#time float between 0.0 to 1.0
	print("time = "+str(time))
	print(str(music.get_playback_position()))
	
	#music management depending on time of day
	#dawn - time=MORNINGSTARTTIME
	if time > MORNINGSTARTTIME and lasttime < MORNINGSTARTTIME:
		music.get_stream_playback().switch_to_clip_by_name("Dawn")
		print("dawn")

	
	#night - NIGHTSTARTTIME < time < MORNINGSTARTTIME
	elif time > NIGHTSTARTTIME or time < MORNINGSTARTTIME:
		music.get_stream_playback().switch_to_clip_by_name("Night")
		print("night")

	
	#evening - EVENINGSTARTTIME < time < NIGHTSTARTTIM
	elif time > EVENINGSTARTTIME:
		music.get_stream_playback().switch_to_clip_by_name("Evening")
		print("evening")

	
	#day - DAYSTARTTIME < time < EVENINGSTARTTIME
	elif time > DAYSTARTTIME:
		music.get_stream_playback().switch_to_clip_by_name("Day")
		print("day")

		
	#morning - MORNINGSTARTTIME < time < DAYSTARTTIME
	#elif time > MORNINGSTARTTIME and music.playing == false:
	#	music.get_stream_playback().switch_to_clip_by_name("Morning")


	
