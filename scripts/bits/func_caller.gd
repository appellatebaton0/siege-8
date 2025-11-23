class_name FuncCaller extends Bit

@export var target:NodeValue
@export var function_name:String

func _ready() -> void:
	for child in get_children(): if child is NodeValue:
		target = child
		break

func call_func(_arg):
	var node = target.value()
	node.call(function_name)
