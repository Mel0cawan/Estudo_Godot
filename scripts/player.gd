extends CharacterBody2D


const SPEED = 100.0
const JUMP_FORCE = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false

@onready var animation := $Anima as AnimatedSprite2D	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() :
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_jumping:
		animation.play("Jump")
	elif is_on_floor():
		if direction:
			animation.play("Run")  # Se movendo no chão, toca "Run"
		else:
			animation.play("Idle")  # Se parado no chão, toca "Idle"

	move_and_slide()
