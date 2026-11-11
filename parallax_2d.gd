extends Parallax2D

@export var scroll_speed = -100
@export var start_speed = -100
@export var max_speed = -700
@export var acceleration = 0.1
@export var distance = 1.0 # Set to 1 so the modulo doesn't mess up
@export var nextobjectivedistance = 1000;
@export var objectivenumber = 1;
@export var clearlock = false; # Makes it so a clear doesn't happen several times when a player meets the objective.
@onready var clear_objective_sound: AudioStreamPlayer2D = $ClearObjectiveSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	autoscroll.x = start_speed
	distance = -1;
	nextobjectivedistance = 1000; # I'm not sure whether or not we actually declare it twice, but for this build I am.
	objectivenumber = 1;
	clearlock = false;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if autoscroll.x >= max_speed:
		autoscroll.x += scroll_speed * delta * acceleration
	distance += scroll_speed * delta * acceleration # I basically just implemented the distance like autoscroll.x but without a cap. If it works correctly, it should just track the accurate distance based on current acceleration.
	if ((int(floor(distance)) % nextobjectivedistance) == 0):
		if clearlock != true:
			objectiveclear()




func objectiveclear() -> void: # This is for the objective stuff
	clearlock = true;
	autoscroll.x = 0;
	clear_objective_sound.play()
	# When timer is implemented, reset it here! ! ! ! ! ! ! ! ! ! !

	print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
	print("-------------------------------------------------")
	print("OBJECTIVE " + str(objectivenumber) + " CLEARED!")
	print("-------------------------------------------------")
	objectivenumber += 1;
	print("Next Objective Number: " + str(objectivenumber))
	print("Next Objective Distance: " + str(nextobjectivedistance)) # Right now, we have this in terms of distance. However, if we got a distance-to-door ratio, then we could easily reformat it to the number of doors, assuming doors are the same distance away from each other.
	print("-------------------------------------------------")
	await get_tree().create_timer(1.0).timeout # Timer to prevent clear from happening several times upon hitting the required x value.
	clearlock = false;



	
