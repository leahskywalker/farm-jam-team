# DayAndNightCycleManager.gd
extends Node

# Defining Minutes in Real Life, and Converting it to a Radian-Based Progression Rate for Game Minutes
const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

#defining dawn and dusk time in progression cycle
const DAWN_TIME: float = 0.2
const DUSK_TIME: float = 0.8

#defining day_period as an int, 0=night, 1=morning, 2=day, 3=evening
var day_period: int = 1

# This Makes the Day ~ 9 Minutes and 20 Seconds Long
var game_speed: float = 2.5

# Initial Starting Time Variables
var initial_day: int = 1
var initial_hour: int = 06
var initial_minute: int = 00

# Initializing and Detecting Changes to Emit Signals
var time: float = 0.0
var current_minute: int = -1
var day_progression: float = 0.0
var current_day: int = 0

signal game_time(time: float)
signal game_day_progression(time: float)
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
	check_day_period()

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

func check_day_period() -> void:
	if (day_progression < DAWN_TIME) or (day_progression > DUSK_TIME):
		day_period = 0
	elif (day_progression < (DUSK_TIME-DAWN_TIME)*0.3+DAWN_TIME):
		day_period = 1
	elif (day_progression > (DUSK_TIME-DAWN_TIME)*0.7+DAWN_TIME):
		day_period = 3
	else:
		day_period = 2
		
func skip_to_time(skip_time: float) -> void:
	if skip_time < time:
		current_day += 1
	time = skip_time
	
