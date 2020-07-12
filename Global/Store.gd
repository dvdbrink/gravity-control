extends Node

var _last_time: int = 0
var _best_time: int = 0

func save(sec: int) -> void:
	_last_time = sec
	if sec < _best_time or 0 == _best_time:
		_best_time = sec

func get_and_reset_last_time() -> int:
	var r = _last_time
	_last_time = 0
	return r

func get_best_time() -> int:
	return _best_time
