class_name PlatformerMove extends MoveBit

@export var jump_velocity := 10.0
@export var gravity := 1.0

@export_group("Ground", "ground_")
@export var ground_acceleration := 10.0
@export var ground_max_speed := 10.0
@export var ground_friction := 10.0

@export_group("Air", "air_")
@export var air_acceleration := 10.0
@export var air_max_speed := 10.0
@export var air_friction := 10.0

@export_group("Leniencies", "len_")
@export var len_coyote_time := 0.1
@export var len_jump_buffer := 0.1
var coyote_time := 0.0
var jump_buffer := 0.0

func _phys_active(delta:float):
	
	var current_friction:float
	var current_acceleration:float
	var current_max_speed:float
	
	## Gravity
	if not mover.is_on_floor():
		mover.velocity += mover.get_gravity() * delta * gravity
		
		current_friction     = air_friction
		current_acceleration = air_acceleration
		current_max_speed    = air_max_speed
	
	## Leniencies 
	jump_buffer = move_toward(jump_buffer, 0, delta)
	if Input.is_action_just_pressed("Jump"):
		jump_buffer = len_jump_buffer
	
	coyote_time = move_toward(coyote_time, 0, delta)
	if mover.is_on_floor():
		coyote_time = len_coyote_time
		
		current_friction     = ground_friction
		current_acceleration = ground_acceleration
		current_max_speed    = ground_max_speed
	
	## Jumping
	if coyote_time > 0 and jump_buffer > 0:
		mover.velocity.y =- jump_velocity
		
		coyote_time = 0
		jump_buffer = 0
	
	## Movement
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		mover.velocity.x = move_toward(mover.velocity.x, direction * current_max_speed, delta * current_acceleration)
	else:
		mover.velocity.x = move_toward(mover.velocity.x, 0, delta * current_friction)
