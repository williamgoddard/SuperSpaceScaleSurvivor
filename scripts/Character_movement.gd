extends CharacterBody2D

const MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000.0
const DECELERATION = 600.0
const AIR_CONTROL = 0.3
const FRICTION = 0.5
const gravity_strength = 800.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var can_double_jump = false
var is_jumping = false
var facing_right
func _ready():
		if not get_parent():
			push_error("Parent node not found")

func _physics_process(delta):
	
	var parent_rotation = get_parent().rotation
	var gravity_direction = Vector2(gravity_strength * sin(parent_rotation), gravity_strength * cos(parent_rotation))
	velocity += gravity_direction * delta
	# Gravity
	#if not is_on_floor():
		#velocity.y += GRAVITY * delta

	# Input
	var input_direction = Input.get_axis("ui_left", "ui_right")

	# Smoother acceleration and deceleration using move_toward
	if input_direction != 0:
		velocity.x = move_toward(velocity.x, input_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	# Air control and momentum preservation
	if not is_on_floor():
		velocity.x = move_toward(velocity.x, input_direction * MAX_SPEED, AIR_CONTROL * delta)
		velocity.x *= 1.0 - FRICTION * delta

	# Jumping with variable height
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumping = true
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
			is_jumping = true

	# Allow holding jump to jump higher
	if is_jumping and not Input.is_action_pressed("ui_accept"):
		if velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
		is_jumping = false

	# Reset double jump flag on landing
	if is_on_floor():
		can_double_jump = true

	# Check if on ground to reset jumping state
	if is_on_floor():
		is_jumping = false

	# Determine facing direction
	if input_direction != 0:
		facing_right = input_direction > 0

	# Update animations
	update_animation()

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
