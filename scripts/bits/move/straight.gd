class_name StraightMove extends MoveBit

@export var max_speed := 15.0
@export var acceleration := 40.0
var speed = 0.0

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_axis("Back", "Forwards")
	
	if direction: speed = move_toward(speed, max_speed * direction, delta * acceleration)
	else:         speed = move_toward(speed, 0, delta * acceleration)
	
	mover.velocity = Vector3(speed, speed, speed) * -bot.global_transform.basis.z
	
	
