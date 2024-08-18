extends CharacterBody2D


const MAX_SPEED = 300.0
const JUMP_VELOCITY = -600.0
const ACCELERATION = 1000.0
const DECELERATION = 600.0
const AIR_CONTROL = 0.3
const FRICTION = 0.5
const DASH_SPEED = 800.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 1.0
const COYOTE_TIME = 0.2

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_jumps = 3
var current_jumps = 0
var jump_cut_off = 0.2
var airtime = 0

var can_double_jump = false
var is_jumping = false
var facing_right = true

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0

func _physics_process(delta):
	#gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Dash logic
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			dash_cooldown_timer = DASH_COOLDOWN
	else:
		if dash_cooldown_timer > 0:
			dash_cooldown_timer -= delta

		#normal movement
		handle_movement(delta)

	move_and_slide()

	update_animation()

func handle_movement(delta):
	#Input
	var input_direction = Input.get_axis("move_left", "move_right")

	#dashing input
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		start_dash(input_direction)

	#Smoother acceleration and deceleration
	if input_direction != 0:
		velocity.x = move_toward(velocity.x, input_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	# Air control and momentum preservation
	if not is_on_floor():
		velocity.x = move_toward(velocity.x, input_direction * MAX_SPEED, AIR_CONTROL * delta)
		velocity.x *= 1.0 - FRICTION * delta

	airtime += delta

	if is_on_floor():
		airtime = 0

	# Reset jumps on landing
	if is_on_floor() or airtime < COYOTE_TIME:
		current_jumps = 0
		is_jumping = false
		
	# Remove first jump if not used in time
	elif current_jumps == 0:
		current_jumps = 1

	# Jumping logic
	if Input.is_action_just_pressed("jump") and current_jumps < max_jumps:
		velocity.y = JUMP_VELOCITY
		current_jumps += 1
		airtime = COYOTE_TIME
	elif Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY * jump_cut_off:
		velocity.y = JUMP_VELOCITY * jump_cut_off

	# Determine facing direction
	if input_direction != 0:
		facing_right = input_direction > 0

func start_dash(direction):
	is_dashing = true
	dash_timer = DASH_DURATION
	dash_direction = direction if direction != 0 else (1 if facing_right else -1)
	velocity.x = dash_direction * DASH_SPEED

func update_animation():
	if is_on_floor():
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		else:
			if facing_right:
				$AnimatedSprite2D.play("run_right")
			else:
				$AnimatedSprite2D.play("run_left")
	else:
		if velocity.y < 0:
			if velocity.x == 0:
				$AnimatedSprite2D.play("jump_idle")
			elif facing_right:
				$AnimatedSprite2D.play("jump_right")
			else:
				$AnimatedSprite2D.play("jump_left")
		else:
			if velocity.x == 0:
				$AnimatedSprite2D.play("fall_idle")
			elif facing_right:
				$AnimatedSprite2D.play("fall_right")
			else:
				$AnimatedSprite2D.play("fall_left")
