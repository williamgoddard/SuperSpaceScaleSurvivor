extends CharacterBody2D


const MAX_SPEED = 500.0
const JUMP_VELOCITY = -620.0
const ACCELERATION = 1500.0
const DECELERATION = 1500.0
const AIR_CONTROL = 0.8
const FRICTION = 1
const DASH_SPEED = 1000.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 1.0
const COYOTE_TIME = 0.2
const GROUND_POUND_SPEED = 1200
const GROUND_POUND_RECOVERY_TIME = 0.5

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_jumps = 3
var current_jumps = 0
var jump_cut_off = 0.2
var airtime = 0

var can_double_jump = false
var is_jumping = false
var facing_right = true

var is_ground_pounding = false
var is_recovering = false
var recovery_timer = 0.0

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0

signal ground_pound_hit

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
	
	if is_recovering:
		recovery_timer -= delta
		if recovery_timer <= 0:
			is_recovering = false
		#when recovery, don't allow movement
		velocity.x = 0
		velocity.y = 0
	
	#ground pound
	if is_ground_pounding:
		velocity.x = 0  
		velocity.y = GROUND_POUND_SPEED  #set ground pound speed
	move_and_slide()
	
	# Check if ground pound hits the ground
	if is_ground_pounding and is_on_floor():
		is_ground_pounding = false
		is_recovering = true
		recovery_timer = GROUND_POUND_RECOVERY_TIME
		emit_signal("ground_pound_hit")

	update_animation()

func handle_movement(delta):
	#Input
	var input_direction = Input.get_axis("move_left", "move_right")
	
	#ground pound
	if Input.is_action_just_pressed("ground_pound") and not is_on_floor() and not is_ground_pounding:
		is_ground_pounding = true
		velocity.x = 0
		velocity.y = GROUND_POUND_SPEED
		return
	
	#dashing input
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		start_dash(input_direction)
		if velocity.y > 0:
			velocity.y = 0

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
	if is_ground_pounding:
		$AnimatedSprite2D.play("ground_pound")
	elif is_recovering:
		$AnimatedSprite2D.play("ground_pound_recovery")
	elif is_dashing:
		if dash_direction > 0:
			$AnimatedSprite2D.play("dash_right")
		else:
			$AnimatedSprite2D.play("dash_left")
	elif is_on_floor():
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
