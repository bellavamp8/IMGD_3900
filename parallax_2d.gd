extends Parallax2D

@onready var speed_controller = get_node("/root/Game/SpeedController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	autoscroll.x = -speed_controller.get_speed()




	
