extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0

var jump_sound = preload("res://audio/sound effects/bc_jump1.wav")
var heavy_hit = preload("res://audio/sound effects/bc_hitheavy_muffled.wav")
var light_hit = preload("res://audio/sound effects/bc_hitlight_muffled.wav")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var footsteps: AudioStreamPlayer = $footsteps
@onready var sweating = false
@onready var alive = true

func play_jump_sound():
	var jump_sound_player = $sound_effects
	jump_sound_player.stream = jump_sound
	jump_sound_player.play()

func play_heavy_hit_sound():
	var heavy_hit_sound_player = $sound_effects
	heavy_hit_sound_player.stream = heavy_hit
	heavy_hit_sound_player.play()

func play_light_hit_sound():
	var light_hit_sound_player = $sound_effects
	light_hit_sound_player.stream = light_hit
	light_hit_sound_player.play()

func is_sweating() -> void:
	sweating = true

func is_not_sweating() -> void:
	sweating = false

func is_alive() -> void:
	alive = false
	

func _physics_process(delta: float) -> void:
	if alive:
		# Add the gravity.
		if not is_on_floor():
			velocity += (get_gravity() * delta*0.8)
		
		if is_on_floor() and sweating:
			footsteps.set_stream_paused(false)
			animated_sprite.play("Run (sweat)")
		elif is_on_floor():
			footsteps.set_stream_paused(false)
			animated_sprite.play("Run")

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			play_jump_sound()
			footsteps.set_stream_paused(true)
			animated_sprite.play("Jump")
	else:
		animated_sprite.play("Fall")
		if animated_sprite.get_frame() == 2:
			animated_sprite.pause()
		animation_player.play("Death")
		footsteps.set_stream_paused(true)
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		get_tree().change_scene_to_file("res://game over.tscn")
