class_name SectionSpawner extends Bit

@export var parent:NodeValue
var real_parent:Node

@export var options:ScenesValue
var real_options:Array[PackedScene]

@export var grid_size := Vector3(14, 14, 14)
@export var spawn_width := 3
@export var clear_width := 4

var rooms:Array[Node]

func has_room_at(coords:Vector3):
	for room in rooms:
		if room.global_position / grid_size == coords: return true
	return false

func spawn_new(coords:Vector3):
	
	coords *= grid_size
	
	var new:Node3D = real_options.pick_random().instantiate()
	
	real_parent.add_child(new)
	new.global_position = coords
	
	rooms.append(new)

func fill_space():
	for i in range(-spawn_width + 1,spawn_width):
		for j in range(-spawn_width + 1,spawn_width):
			for k in range(-spawn_width + 1,spawn_width):
				var coords = Vector3(i,j,k) + (grid_lock(bot.global_position) / grid_size)
				if not has_room_at(coords):
					spawn_new(coords)

func clear_space():
	for room in rooms:
		if room.global_position.distance_to(bot.global_position) > clear_width * grid_size.x:
			rooms.erase(room)
			room.queue_free()

func grid_lock(from:Vector3) -> Vector3:
	var v:Vector3
	
	v.x = floor(from.x / grid_size.x) * grid_size.x
	v.y = floor(from.y / grid_size.y) * grid_size.y
	v.z = floor(from.z / grid_size.z) * grid_size.z

	return v

func _ready() -> void:
	for child in get_children():
		if child is ScenesValue and options == null:
			options = child
		if child is NodeValue and parent == null:
			parent = child
	
	real_options = options.value()
	real_parent  = parent.value()

func _process(delta: float) -> void:
	fill_space()
	clear_space()
	
	var me = self
	if me is Node3D:
		me.global_position = grid_lock(bot.global_position)
