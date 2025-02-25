#DN_music_manager.gd
extends Node

@export var interactive_music: AudioStreamPlayer
@export var music_stream: AudioStreamInteractive

# Time of day value (0.0 to 1.0)
@export var time_of_day: float = 0.0
@export var special_clips: Dictionary = { 0.2: 0, 2.0: 1 }  # Time offsets mapped to special clip indices
@export var default_offset: float = 0.2

var played_special_clips: Dictionary = {}
var current_special_clip: int = -1
var special_clip_timer: Timer

var clip_index = 1
var last_index = 1

func _ready():
	#connect the time signal here (0.0f to 1.0f)
	DayAndNightCycleManager.game_day_progression.connect(update_time)
	
	#interactive_music must already be instantiated and is referred here
	interactive_music = $music
	music_stream = interactive_music.stream

	if interactive_music and music_stream:
		interactive_music.play()
	
	# Initialize played status for each special clip
	for key in special_clips.keys():
		played_special_clips[key] = false
		
			# Create a timer to track special clip duration
	special_clip_timer = Timer.new()
	special_clip_timer.one_shot = true
	special_clip_timer.timeout.connect(_on_special_clip_finished)
	add_child(special_clip_timer)

func _process(_delta):
	if interactive_music and music_stream:
		reset_special_clips_if_needed()
		choose_music_clip()

func reset_special_clips_if_needed():
	# Reset played status when time_of_day loops back to start
	if special_clips.size() > 0:
		var first_offset = special_clips.keys()[0] if special_clips.size() == 1 else special_clips.keys().min()
		if time_of_day < first_offset:
			for key in special_clips.keys():
				played_special_clips[key] = false
			current_special_clip = -1

func choose_music_clip():
	if not interactive_music.playing:
		return
	
	var clip_count = music_stream.get_clip_count()
	if clip_count == 0:
		return
	
	# Check if any special clip should be played
	for offset in special_clips.keys():
		if time_of_day >= offset and not played_special_clips[offset]:
			current_special_clip = special_clips[offset]
			switch_clip(current_special_clip)
			played_special_clips[offset] = true
			
			# Dynamically get clip duration
			special_clip_timer.start(get_clip_length(current_special_clip))
			return

	if current_special_clip == -1:
		
		# Determine which clip to play based on time_of_day after special clips have played
		last_index = clip_index
		var first_offset = special_clips.keys()[0] if special_clips.size() == 1 else special_clips.keys().min() if special_clips.size() > 0 else 0.0
		var normal_clip_count = clip_count - special_clips.size()
		
		if time_of_day >= first_offset:
			clip_index = int((time_of_day - first_offset) * normal_clip_count) + 1
			clip_index = min(clip_index, clip_count - 1)
		else:
			clip_index = clip_count - 1  # Play highest index clip below offset
			
		#adapt the night music for darkness
		if clip_index == 4:
			pass
		
		#print("clip index : "+str(clip_index))
		#print("playing : "+str(interactive_music.playing)+" position : "+str(interactive_music.get_playback_position()))
		if last_index != clip_index:
			switch_clip(clip_index)

func switch_clip(index):
	interactive_music.get_stream_playback().switch_to_clip(index)

func update_time(time):
	time_of_day = time
	print("time is : "+str(time_of_day))
	
func get_clip_length(clip_index: int) -> float:
	var clip_length = music_stream.get_clip_stream(clip_index).get_length()
	print("clip_lenght : "+str(clip_length))
	return max(clip_length,5.0)  # Return duration in real seconds or default value
	
func _on_special_clip_finished():
	current_special_clip = -1
	
