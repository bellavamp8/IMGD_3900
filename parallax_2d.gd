extends Parallax2D

@export var scroll_speed = -100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	autoscroll.x = scroll_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scroll_speed >= -500:
		autoscroll.x += scroll_speed * delta * 0.1
