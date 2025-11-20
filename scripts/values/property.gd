class_name PropertyValue extends Value

@export var from:NodeValue
@export var property_name:String

func _ready() -> void:
	if from == null: for child in get_children(): if child is NodeValue: 
		from = child
		break
	

func value() -> Variant:
	
	if from != null: 
		var fvalue = from.value()
		if property_name.contains("()"): 
			return fvalue.call(property_name.replace("()",""))
		else: 
			return fvalue.get(property_name)
	
	return null
