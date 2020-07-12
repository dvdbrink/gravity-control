extends Node

enum Level {
	TRACE,
	DEBUG,
	INFO,
	WARNING,
	ERROR,
	FATAL
}

func t(msg: String) -> void:
	_log(Level.TRACE, msg)

func d(msg: String) -> void:
	_log(Level.DEBUG, msg)

func i(msg: String) -> void:
	_log(Level.INFO, msg)

func w(msg: String) -> void:
	_log(Level.WARNING, msg)

func e(msg: String) -> void:
	_log(Level.ERROR, msg)

func f(msg: String) -> void:
	_log(Level.FATAL, msg)

func _log(lvl: int, msg: String) -> void:
	print("[%s] %s" % [Level.keys()[lvl], msg])
