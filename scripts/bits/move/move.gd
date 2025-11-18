@abstract class_name MoveBit extends Bit

@onready var mover:CharacterBody2D
@onready var master:MoveMasterBit

@onready var next_bits := get_next_bits()
func get_next_bits() -> Array[MoveBit]:
	var response:Array[MoveBit]
	
	for child in get_children(): if child is MoveBit:
		response.append(child)
	
	return response

func pass_call(call_name:String, arg = null):
	if arg != null:
		call(call_name, arg)
		
		for bit in next_bits: bit.pass_call(call_name, arg)
	else:
		call(call_name)
		
		for bit in next_bits: bit.pass_call(call_name)
func init_with(set_mover:CharacterBody2D, set_master:MoveMasterBit):
	mover  = set_mover
	master = set_master
	
	for bit in next_bits:
		bit.init_with(set_mover, set_master)

func _on_active():
	pass
func _on_inactive():
	pass

func _active(_delta:float):
	pass
func _inactive(_delta:float):
	pass

func _phys_active(_delta:float):
	pass
func _phys_inactive(_delta:float):
	pass
