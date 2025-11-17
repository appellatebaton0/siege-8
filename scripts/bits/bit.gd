@abstract class_name Bit extends Bot

@export var isolated := false

@onready var bot := get_bot()
func get_bot(depth := 4, with = self) -> Bot:
	if with is Bit:
		if with.isolated: return with
		return with.get_bot(depth - 1, with.get_parent())
	elif with is Bot: return with
	return get_bot(depth - 1, with.get_parent())
	
	print()
