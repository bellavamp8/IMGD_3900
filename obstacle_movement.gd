extends Node2D

@onready var speed_controller = get_node("/root/Game/SpeedController")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x = self.position.x - (speed_controller.get_speed()  * delta)
	if position.x <= -1500:
		queue_free() # Delete this node
