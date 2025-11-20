class_name CastBool extends BoolValue

@export var input:Value

func _ready() -> void: if input == null:
	for child in get_children(): if child is Value:
		input = child
		break

func value() -> bool:
	if input != null:
		var ivalue = input.value()
		
		if ivalue is bool or ivalue is float or ivalue is int:
			return bool(ivalue)
	
	return false
