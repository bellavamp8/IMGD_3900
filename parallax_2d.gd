extends Parallax2D

@export var scroll_speed = -100
@export var start_speed = -100
@export var max_speed = -700
@export var acceleration = 0.1
@export var distance = 1.0 # Set to 1 so the modulo doesn't mess up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	autoscroll.x = start_speed
	distance = 1.0;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if autoscroll.x >= max_speed:
		autoscroll.x += scroll_speed * delta * acceleration
	distance += scroll_speed * delta * acceleration # I basically just implemented the distance like autoscroll.x but without a cap. If it works correctly, it should just track the accurate distance based on current acceleration.
	print(distance); # DEBUG PRINT
	if ((int(distance) % 1000) == 0):
		objectiveclear()
		print( "   MOD  ")




func objectiveclear() -> void: # This is for the objective stuff
	autoscroll.x = 0;
	



	
