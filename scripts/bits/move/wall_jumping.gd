class_name WallJumpMove extends MoveBit

@export var jump_velocity := Vector2(100, 100)

@export_group("Leniencies", "len_")
@export var len_coyote_time := 0.1
@export var len_jump_buffer := 0.1
var coyote_time := 0.1
var jump_buffer := 0.1

var last_wall_normal:float
func _phys_active(delta:float):
	
	## Leniencies 
	jump_buffer = move_toward(jump_buffer, 0, delta)
	if Input.is_action_just_pressed("Jump"):
		jump_buffer = len_jump_buffer
	
	coyote_time = move_toward(coyote_time, 0, delta)
	if mover.is_on_wall_only():
		coyote_time = len_coyote_time
		last_wall_normal = mover.get_wall_normal().x
	
	## Jumping
	if coyote_time > 0 and jump_buffer > 0:
		
		if abs(jump_velocity.x) > mover.velocity.x: mover.velocity.x = jump_velocity.x * last_wall_normal
		if abs(jump_velocity.y) > mover.velocity.y: mover.velocity.y = -jump_velocity.y
		
		coyote_time = 0
		jump_buffer = 0
	
