class_name ReplacerBit extends Bit

@export var target:NodeValue
@export var property:String

@export var with:Value

func _ready() -> void:
	for child in get_children():
		if child is NodeValue and target == null:
			target = child
		elif child is Value and with == null:
			with = child

func _process(_delta: float) -> void:
	if target != null and with != null:
		var node = target.value()
		
		var wvalue = with.value()
		
		node.set(property, lerp(node.get(property),wvalue, 0.5))
