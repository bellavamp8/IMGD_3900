extends Node2D

@onready var speed_controller = get_node("/root/Game/SpeedController")
@onready var obstacle_spawner = get_node("/root/Game/ObstacleSpawner")
@onready var area_sign: Area2D = $Area2D_Sign
@onready var area_plant: Area2D = $Area2D_Plant
@onready var animated_sprite_sign: AnimatedSprite2D = $Area2D_Sign/AnimatedSprite2D_sign
@onready var animated_sprite_plant: AnimatedSprite2D = $Area2D_Sign/AnimatedSprite2D_sign
@onready var hit_sound: AudioStreamPlayer2D = $/root/Game/Player/CharacterBody2D/HitSoundLight
@onready var scrolling = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if obstacle_spawner.obstacle_spawned == 0:
		area_sign.body_entered.connect(_on_body_entered)
		animated_sprite_sign.play("Idle")
	else:
		area_plant.body_entered.connect(_on_body_entered)
		animated_sprite_plant.play("Idle")

func is_scrolling() -> void:
	scrolling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if scrolling:
		self.position.x = self.position.x - (speed_controller.get_speed()  * delta)
		if position.x <= -1500:
			queue_free() # Delete this node
	else:
		self.position.x = self.position.x

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		speed_controller.set_speed(speed_controller.get_speed() * 0.4)
		area_sign.set_deferred("monitoring", false)
		animated_sprite_sign.play("Hit")
		area_plant.set_deferred("monitoring", false)
		animated_sprite_plant.play("Hit")
		hit_sound.play()
