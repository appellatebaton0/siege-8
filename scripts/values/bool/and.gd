class_name AndBool extends BoolValue

@export var inputs:Array[BoolValue]

func _ready() -> void:
	for child in get_children(): if child is BoolValue:
		inputs.append(child)

func value() -> bool:
	var response = true
	
	for input in inputs: if input != null:
		if not input.value(): response = false
	
	return response
