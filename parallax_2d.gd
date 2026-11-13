extends Parallax2D

@onready var speed_controller = get_node("/root/Game/SpeedController")
@onready var scrolling = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func is_scrolling() -> void:
	scrolling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	autoscroll.x = -speed_controller.get_speed()
	
	if not scrolling:
		autoscroll.x = 0




	
