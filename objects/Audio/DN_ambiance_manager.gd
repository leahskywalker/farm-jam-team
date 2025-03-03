#DN_music_manager.gd
extends Node

@export var interactive_music: AudioStreamPlayer
@export var music_stream: AudioStreamInteractive

# Time of day value (0.0 to 1.0)
@export var time_of_day: float = 0.0

var clip_index = 0
var last_index = 0

var day_period: int = 1

func _ready():
	#connect the time signal here (0.0f to 1.0f)
	DayAndNightCycleManager.game_day_progression.connect(update_time)
	
	#interactive_music must already be instantiated and is referred here
	interactive_music = $ambience
	music_stream = interactive_music.stream

	if interactive_music and music_stream:
		interactive_music.play()
	

func _process(_delta):
	if interactive_music and music_stream:
		choose_clip()


func choose_clip():
	if not interactive_music.playing:
		return
	
	var clip_count = music_stream.get_clip_count()
	if clip_count == 0:
		return
	
	update_day_period()
	
	last_index = clip_index
	
	if day_period == 0: #night
		clip_index = 1
	else: #day
		clip_index = 0


	if last_index != clip_index:
		switch_clip(clip_index)

func switch_clip(index):
	interactive_music.get_stream_playback().switch_to_clip(index)

func update_time(time):
	time_of_day = time
	#print("time is : "+str(time_of_day))
	
func get_clip_length(clip_index: int) -> float:
	var clip_length = music_stream.get_clip_stream(clip_index).get_length()
	#print("clip_lenght : "+str(clip_length))
	return max(clip_length,5.0)  # Return duration in real seconds or default value
	
	
func update_day_period():
	day_period = DayAndNightCycleManager.day_period
	#print("day_period : "+str(day_period))
