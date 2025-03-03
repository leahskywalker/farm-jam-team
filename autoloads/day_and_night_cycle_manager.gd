# DayAndNightCycleManager.gd
extends Node

# Defining Minutes in Real Life, and Converting it to a Radian-Based Progression Rate for Game Minutes
const MINUTES_PER_HOUR: int = 60
const HOURS_PER_DAY: int = 24
const MINUTES_PER_DAY: int = HOURS_PER_DAY * MINUTES_PER_HOUR
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
	var initial_total_minutes = (initial_day-1) * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	
	time = initial_total_minutes * GAME_MINUTE_DURATION

# Calculate Time Ticks to Emit
func recalculate_time() -> void:
	var total_minutes: int = total_minutes(time)
	var day: int = floori(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = day_minutes(total_minutes)
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
		

# Function to Skip to 6 AM the Next Day
func skip_to_next_morning() -> void:
	var morning_def: float = DAWN_TIME
	var morning_time: int = morning_def*MINUTES_PER_DAY
	skip_to(morning_time)
	
func skip_to(skip_dest: float) -> void:
	var total_minutes: int = total_minutes(time)
	var current_day_minutes: int = day_minutes(total_minutes)
	
	var minutes_until_dest: int
	if skip_dest < current_day_minutes:
		minutes_until_dest = (MINUTES_PER_DAY - current_day_minutes) + (skip_dest)
	else:
		minutes_until_dest = (skip_dest - current_day_minutes) 
		
	print("skip_dest : "+str(skip_dest))
	print("time : "+str(time)+ ", total_minutes : "+str(total_minutes))
	print("current_day_minutes : "+str(current_day_minutes)+ ", minutes_until_dest : "+str(minutes_until_dest))
		
	time += minutes_until_dest * GAME_MINUTE_DURATION
	recalculate_time()
	
func total_minutes(total_time: float) -> int:
	var total_minutes: int = floori(total_time / GAME_MINUTE_DURATION)
	return total_minutes
	
func day_minutes(minutes_count: int) -> int:
	var current_day_minutes: int = minutes_count % MINUTES_PER_DAY
	return current_day_minutes

func days_passed_since_start(minutes_count: int)-> float:
	var current_days_passed: int = minutes_count / MINUTES_PER_DAY
	return current_days_passed
