extends Node2D

@onready var speed_controller = get_node("/root/Game/SpeedController")
@onready var area: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x = self.position.x - (speed_controller.get_speed()  * delta)
	if position.x <= -1500:
		queue_free() # Delete this node

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		speed_controller.reset_speed()
		area.set_deferred("monitoring", false)
