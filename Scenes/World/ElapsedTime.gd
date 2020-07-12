extends Label
class_name ElapsedTime

var minutes = 0
var seconds = 0

onready var timer: Timer = $Timer

func _ready():
	_update_text()
	
	timer.connect("timeout", self, "_increment_time")
	timer.set_one_shot(false)
	timer.set_wait_time(1)
	timer.start()

func _increment_time():
	seconds += 1
	if seconds >= 60:
		minutes += 1
		seconds = 0
	_update_text()

func _update_text():
	text = "%02d:%02d" % [minutes, seconds]

func get_elapsed_seconds() -> int:
	return seconds + (minutes * 60)
