class_name SectionSpawner extends Bit

@export var options:ScenesValue

@export var grid_size := Vector3(14, 14, 14)

func grid_lock(from:Vector3) -> Vector3:
	var v:Vector3
	v.x = floor(from.x / grid_size.x) * grid_size.x
	v.y = floor(from.y / grid_size.y) * grid_size.y
	v.z = floor(from.z / grid_size.z) * grid_size.z
	return v

func _ready() -> void:
	if options == null: for child in get_children():
		if child is ScenesValue:
			options = child
			break

func _process(delta: float) -> void:
	var me = self
	if me is Node3D:
		
		me.global_position = grid_lock(bot.global_position)
