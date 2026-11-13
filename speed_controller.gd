extends Node2D

# Speed variables
@export var start_speed: float = 200
@export var max_speed: float = 1000
@export var acceleration: float = 8
var current_speed = start_speed

# Distance variables
@export var start_distance: float = 300
@export var distance_between_doors: float = 384
var distance = start_distance
var current_door: int = 0

# Objective variables
@export var next_objective_door = 50;
var objective_number = 1;
var clear_lock = false; # Makes it so a clear doesn't happen several times when a player meets the objective.
@onready var clear_objective_sound: AudioStreamPlayer2D = $ClearObjectiveSound

# Gets the current speed
func get_speed() -> float:
	return current_speed

# Gets distance percentage (for progress bar)
func get_progress() -> float:
	return (distance / distance_between_doors)

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_speed <= max_speed:
		current_speed += delta * acceleration
	distance += delta * current_speed
	current_door = int(floor(distance)) / distance_between_doors
	if current_door % next_objective_door == 0 && current_door != 0:
		if clear_lock != true:
			objectiveclear()

func objectiveclear() -> void: # This is for the objective stuff
	clear_lock = true;
	current_speed = start_speed
	clear_objective_sound.play()
	get_tree().call_group("timer", "reset_timer")


	print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
	print("-------------------------------------------------")
	print("OBJECTIVE " + str(objective_number) + " CLEARED!")
	print("-------------------------------------------------")
	objective_number += 1;
	print("Next Objective Number: " + str(objective_number))
	print("Next Objective Door: " + str(next_objective_door))
	print("-------------------------------------------------")
	await get_tree().create_timer(10.0).timeout # Timer to prevent clear from happening several times upon hitting the required x value.
	clear_lock = false;
