extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0

var jump_sound = preload("res://audio/sound effects/bc_jump1.wav")

func play_jump_sound():
		var jump_sound_player = $AudioStreamPlayer2
		jump_sound_player.stream = jump_sound
		jump_sound_player.play()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta*0.8)
	


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		play_jump_sound()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
