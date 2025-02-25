# DayAndNightCycleManager.gd
extends Node

# Defining Minutes in Real Life, and Converting it to a Radian-Based ProgressionRate for Game Minutes
const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

# This Makes the Day ~ 9 Minutes and 20 Seconds Long
var game_speed: float = 10.0

# Initial Starting Time Variables
var initial_day: int = 1
var initial_hour: int = 6
var initial_minute: int = 00

# Initializing and Detecting Changes to Emit Signals
var time: float = 0.0
var current_minute: int = -1
var day_progression: float = 0.0
var current_day: int = 0

signal game_day_progression(time: float)
signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)

# Set Initial Starting Time
func _ready() -> void:
	set_initial_time()

# Emit Time Ticks
func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	game_day_progression.emit(day_progression)
	
	recalculate_time()

# Calculate Initial Starting Time
func set_initial_time() -> void:
	var initial_total_minutes = initial_day * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_DAY) + initial_minute
	
	time = initial_total_minutes * GAME_MINUTE_DURATION

# Calculate Time Ticks to Emit
func recalculate_time() -> void:
	var total_minutes: int = floori(time / GAME_MINUTE_DURATION)
	var day: int = floori(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	var hour: int = floori(current_day_minutes / MINUTES_PER_HOUR)
	var minute: int = current_day_minutes % MINUTES_PER_HOUR
	
	day_progression = float(current_day_minutes)/MINUTES_PER_DAY
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day, hour, minute)
	
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
