class_name LerpMove extends MoveBit
## Lerps towards another node.

@export_range(0.0, 1.0) var lerp_weight = 0.3
@export var target:NodeValue

@export_group("Follow Axes", "follow_")
@export var follow_x := true
@export var follow_y := true
@export var follow_z := true

func _ready() -> void:
	if target == null:
		for child in get_children(): if child is NodeValue:
			target = child
			break

func _physics_process(_delta: float) -> void:
	if target != null and bot != null:
		var node = target.value()
		if node is Node3D and bot.is_class("Node3D"):
			if follow_x: bot.global_position.x = lerp(bot.global_position.x, node.global_position.x, lerp_weight)
			if follow_y: bot.global_position.y = lerp(bot.global_position.y, node.global_position.y, lerp_weight)
			if follow_y: bot.global_position.z = lerp(bot.global_position.z, node.global_position.z, lerp_weight)
		
