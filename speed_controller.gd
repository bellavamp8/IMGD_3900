extends Node2D

# Speed variables
# Acceleration curve scales with both max speed and accel factor
@export var start_speed: float = 100
@export var max_speed: float = 500
@export var accel_factor: float = 0.04
var current_speed = start_speed

# Distance variables
@export var start_distance: float = 300
@export var distance_between_doors: float = 384
var distance = start_distance
var current_door: int = 0

# Objective variables
var distance_between_objectives = 30;
var next_objective_door = distance_between_objectives
var previous_objective_door = 0
var objective_number = 1
var big_clear_lock = false # Makes it so a clear doesn't happen several times when a player meets the objective.
var mini_clear_lock = false
@onready var clear_objective_sound: AudioStreamPlayer2D = $ClearObjectiveSound
@export var miniobjective = 0; #This is the progression value used for spawning, so it's equal to 1/3 of a regular objective.

# Gets the current speed
func get_speed() -> float:
	return current_speed

# Gets percent distance to next objective (for progress bar)
func get_progress() -> float:
	return (float(current_door) - float(previous_objective_door)) / (float(next_objective_door) - float(previous_objective_door)) * 100

# Gets remaining distance (for progress bar)
func get_remaining() -> float:
	return (distance_between_doors - distance)

# Sets the speed, keeping it within boundaries
func set_speed(speed: float) -> void:
	current_speed = speed
	if current_speed > max_speed:
		current_speed = max_speed
	if current_speed < 0:
		current_speed = 0
		
# Modifies the speed by the given amount (positive or negative), keeping it within boundaries
func change_speed(difference: float) -> void:
	current_speed += difference
	if current_speed > max_speed:
		current_speed = max_speed
	if current_speed < 0:
		current_speed = 0

func reset_speed() -> void:
	current_speed = start_speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	
	# Accelerate
	if current_speed <= max_speed:
		current_speed += (accel_factor * max_speed) / (current_speed + 1)
	
	# Increase distance
	distance += delta * current_speed
	current_door = int(floor(distance)) / distance_between_doors
	
	
	if (current_door % (distance_between_objectives / 3) == 0) and (current_door != 0):
		if mini_clear_lock != true:
			miniobjectiveclear();
	
	
	if current_door % next_objective_door == 0 && current_door != 0:
		if big_clear_lock != true:
			objectiveclear()
			




func objectiveclear() -> void:
	big_clear_lock = true
	clear_objective_sound.play()
	get_tree().call_group("timer", "reset_timer")

	objective_number += 1

	if (objective_number == 2):
		start_speed = 150
		max_speed = 750
		accel_factor = 0.06
		distance_between_objectives = 60
	if (objective_number == 3):
		start_speed = 225
		max_speed = 1075
		accel_factor = 0.09
		distance_between_objectives = 90

	current_speed = start_speed
	previous_objective_door = next_objective_door
	next_objective_door += distance_between_objectives

	print("-------------------------------------------------")
	print("OBJECTIVE " + str(objective_number - 1) + " CLEARED!")
	print("-------------------------------------------------")
	print("Next Objective Number: " + str(objective_number))
	print("Next Objective Door: " + str(next_objective_door))
	print("-------------------------------------------------")

	await get_tree().create_timer(10.0).timeout
	big_clear_lock = false
	
	
	
func miniobjectiveclear() -> void:
	mini_clear_lock = true;
	miniobjective += 1;
	await get_tree().create_timer(5.0).timeout # Timer to prevent clear from happening several times upon hitting the required x value.
	mini_clear_lock = false;
