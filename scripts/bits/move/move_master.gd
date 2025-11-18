class_name MoveMasterBit extends Bit

@onready var mover := get_mover()
func get_mover(depth := 2, with:Node = self) -> CharacterBody2D:
	if depth <= 0: return null
	if with is CharacterBody2D: return with
	else: return get_mover(depth - 1, with.get_parent())

@onready var move_bits := get_move_bits()
func get_move_bits() -> Array[MoveBit]:
	var response:Array[MoveBit]
	
	for child in get_children(): if child is MoveBit:
		response.append(child)
	
	return response

var current_bit:MoveBit
@export var initial_bit:MoveBit

func change_to(bit:MoveBit):
	if current_bit != null:
		current_bit.pass_call("_on_inactive")
	
	current_bit = bit
	
	if current_bit != null:
		current_bit.pass_call("_on_active")

func _ready() -> void:
	if initial_bit != null:
		change_to(initial_bit)
	elif len(move_bits) > 0:
		change_to(move_bits[0])
	
	for bit in move_bits:
		bit.mover = mover
		bit.master = self

func _process(delta: float) -> void:
	for bit in move_bits:
		if bit == current_bit: bit.pass_call("_active", delta)
		else:                  bit.pass_call("_inactive", delta)

func _physics_process(delta: float) -> void: if mover != null:
	
	for bit in move_bits:
		if bit == current_bit: bit.pass_call("_phys_active", delta)
		else:                  bit.pass_call("_phys_inactive", delta)
	
	mover.move_and_slide()
	
	if bot != mover:
		if bot != null: if bot.is_class("Node2D"): bot.global_position += mover.position
		mover.position = Vector2.ZERO
	
