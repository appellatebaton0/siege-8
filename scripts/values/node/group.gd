class_name GroupNode extends NodeValue

@export var group_name:String

func value() -> Node:
	return get_tree().get_first_node_in_group(group_name)
