extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = 1
	self.position.x = self.position.x - speed
	if position.x <= -1500:
		queue_free() # Delete this node
