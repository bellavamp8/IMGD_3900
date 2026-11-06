extends Parallax2D

@export var scroll_speed = -100
@export var start_speed = -100
@export var max_speed = -700
@export var acceleration = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	autoscroll.x = start_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if autoscroll.x >= max_speed:
		autoscroll.x += scroll_speed * delta * acceleration
