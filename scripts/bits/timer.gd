class_name TimerBit extends Bit

signal reached_zero
signal added

@export var max_time := 40.0
@export var add_amount := 8.0
var time

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	if time > 0: time = move_toward(time, 0, delta)
	
	if time == 0:
		time = -1
		reached_zero.emit()

func add():
	added.emit()
	
	time = min(max_time, time + add_amount)

func reset():
	time = max_time
