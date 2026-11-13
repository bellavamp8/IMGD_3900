extends Node2D

@export var start_speed: float = 300
@export var max_speed: float = 1000
@export var acceleration: float = 5
var current_speed = start_speed

var distance: float = 1.0 # Set to 1 so the modulo doesn't mess up
@export var next_objective_distance = 50000;
var objective_number = 1;
var clear_lock = false; # Makes it so a clear doesn't happen several times when a player meets the objective.
@onready var clear_objective_sound: AudioStreamPlayer2D = $ClearObjectiveSound

func get_speed() -> float:
	return current_speed
	
func set_speed(speed: float) -> void:
	current_speed = speed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	distance = -1;
	objective_number = 1;
	clear_lock = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_speed <= max_speed:
		current_speed += delta * acceleration
	distance += delta * current_speed
	print(distance)
	if ((int(floor(distance)) % next_objective_distance) == 0):
		if clear_lock != true:
			objectiveclear()




func objectiveclear() -> void: # This is for the objective stuff
	clear_lock = true;
	current_speed = start_speed
	#clear_objective_sound.play()
	get_tree().call_group("timer", "reset_timer")


	print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
	print("-------------------------------------------------")
	print("OBJECTIVE " + str(objective_number) + " CLEARED!")
	print("-------------------------------------------------")
	objective_number += 1;
	print("Next Objective Number: " + str(objective_number))
	print("Next Objective Distance: " + str(next_objective_distance)) # Right now, we have this in terms of distance. However, if we got a distance-to-door ratio, then we could easily reformat it to the number of doors, assuming doors are the same distance away from each other.
	print("-------------------------------------------------")
	await get_tree().create_timer(10.0).timeout # Timer to prevent clear from happening several times upon hitting the required x value.
	clear_lock = false;
