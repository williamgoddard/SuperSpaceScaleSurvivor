extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000.0
const DECELERATION = 600.0
const AIR_CONTROL = 0.3
const FRICTION = 0.5
var gravity_strength = 800.0

var can_double_jump = false
var is_jumping = false
var facing_right = true

func _ready():
	if not get_parent():
		push_error("Parent node not found")

func _physics_process(delta):
	var parent_transform = global_transform

	# Check and print the parent's transform to debug
	print(parent_transform)

	# Apply gravity in the direction of the parent's y-axis
	var gravity_direction = parent_transform.y * gravity_strength
	velocity += gravity_direction * delta

	# Handle input direction (left or right)
	var input_direction = Input.get_axis("ui_left", "ui_right")
	var move_direction = parent_transform.x * input_direction

	# Apply movement with smooth acceleration and deceleration
	if input_direction != 0:
		velocity = velocity.move_toward(move_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	# Air control and momentum preservation
	if not is_on_floor():
		velocity = velocity.move_toward(move_direction * MAX_SPEED, AIR_CONTROL * delta)
		velocity *= 1.0 - FRICTION * delta

	# Jumping logic
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumping = true
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			is_jumping = true

	# Control jump height
	if is_jumping and not Input.is_action_pressed("ui_accept"):
		if velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		is_jumping = false

	# Reset double jump on landing
	if is_on_floor():
		can_double_jump = true

	# Determine facing direction
	if input_direction != 0:
		facing_right = input_direction > 0

	# Update animations
	update_animation()

	# Move the character with the adjusted velocity
	move_and_slide()

func update_animation():
	if is_on_floor():
		if velocity.x == 0:
			
			# Idle animation
			if facing_right:
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("idle")
		else:
			#run animation
			if facing_right:
				$AnimatedSprite2D.play("run_right")
			else:
				$AnimatedSprite2D.play("run_left")
	else:
		if velocity.x == 0 and velocity.y > 0:
			$AnimatedSprite2D.play("jump_idle")
		elif velocity.x > 0  and velocity.y > 0:
			if facing_right:
				$AnimatedSprite2D.play("jump_right")
			else:
				$AnimatedSprite2D.play("jump_left")
		elif velocity.x == 0:
			$AnimatedSprite2D.play("fall_idle")
		else:
			if facing_right:
				$AnimatedSprite2D.play("fall_right")
			else:
				$AnimatedSprite2D.play("fall_left")
