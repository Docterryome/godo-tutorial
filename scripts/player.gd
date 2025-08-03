extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP = 1
const JUMP_DELTA = .9
@onready var anmated_sprite = $AnimatedSprite2D
var jump_num = 0

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if anmated_sprite.animation == "death":
		return
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_num = 1
		velocity.y = JUMP_VELOCITY
	# Double Jump
	elif Input.is_action_just_pressed("ui_accept") and jump_num <= MAX_JUMP:
		jump_num += 1
		velocity.y = JUMP_VELOCITY * JUMP_DELTA

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction < 0:
		anmated_sprite.flip_h = true
	elif direction > 0:
		anmated_sprite.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		anmated_sprite.animation = "run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anmated_sprite.animation = "idle"

	move_and_slide()
