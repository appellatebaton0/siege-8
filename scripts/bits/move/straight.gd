class_name StraightMove extends MoveBit

@export var max_speed := 6.0
@export var acceleration := 40.0
var x_speed = 0.0
var y_speed = 0.0
var z_speed = 0.0

func _physics_process(delta: float) -> void:
	
	var x_dir = Input.get_axis("Left", "Right")
	var y_dir = Input.get_axis("Down", "Up")
	var z_dir = Input.get_axis("Back", "Forwards")
	
	if z_dir: z_speed = move_toward(z_speed, max_speed * z_dir, delta * acceleration)
	else:     z_speed = move_toward(z_speed, 0, delta * acceleration)
	if x_dir: x_speed = move_toward(x_speed, max_speed * x_dir, delta * acceleration)
	else:     x_speed = move_toward(x_speed, 0, delta * acceleration)
	if y_dir: y_speed = move_toward(y_speed, max_speed * y_dir, delta * acceleration)
	else:     y_speed = move_toward(y_speed, 0, delta * acceleration)
	
	
	var velo:Vector3 = Vector3.ZERO
	velo += x_speed *  bot.global_transform.basis.x
	velo += y_speed *  bot.global_transform.basis.y
	velo += z_speed * -bot.global_transform.basis.z
	
	mover.velocity = velo
	
	
	
