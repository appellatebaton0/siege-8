class_name InputBit extends Bit

signal just_pressed
signal just_true
signal just_false

@export var input_name := ""
@export var condition:BoolValue

func _ready() -> void: if condition == null:
	for child in get_children(): if child is BoolValue:
		condition = child
		break

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed(input_name):
		
		print("I")
		
		if condition != null:
			var cvalue = condition.value()
			print("C -> ", cvalue)
			if cvalue: just_true .emit()
			else:      just_false.emit()
		
		just_pressed.emit()
