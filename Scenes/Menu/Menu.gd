extends Node2D

const TWEEN_DURATION = .25

onready var player: Player = $Player
onready var lastResult: Label = $CanvasLayer/Menu/VBoxContainer/LastResult
onready var bestResult: Label = $CanvasLayer/Menu/VBoxContainer/BestResult
onready var tween: Tween = $CanvasLayer/Tween
onready var help = $CanvasLayer/Help
onready var menu = $CanvasLayer/Menu
onready var credits = $CanvasLayer/Credits

func _ready():
	player.velocity = Vector2(500, 0)
	
	var last_result = Store.get_and_reset_last_time()
	var best_result = Store.get_best_time()
	if last_result > 0:
		lastResult.text = "Last result: %s" % _format_seconds(last_result)
		bestResult.text = "Best result: %s" % _format_seconds(best_result)
	else:
		lastResult.visible = false
		bestResult.visible = false

func _on_start_button_pressed():
	get_tree().change_scene("res://Scenes/World/World.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_help_button_pressed():
	_tween_views(1024)

func _on_credits_button_pressed():
	_tween_views(-1024)

func _on_help_back_button_pressed():
	_tween_views(-1024)

func _on_credits_back_button_pressed():
	_tween_views(1024)

func _tween_views(offset: float) -> void:
	tween.interpolate_property(
		help,
		"rect_position:x",
		help.rect_position.x,
		help.rect_position.x + offset,
		TWEEN_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		menu,
		"rect_position:x",
		menu.rect_position.x,
		menu.rect_position.x + offset,
		TWEEN_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.interpolate_property(
		credits,
		"rect_position:x",
		credits.rect_position.x,
		credits.rect_position.x + offset,
		TWEEN_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()

func _format_seconds(sec: int) -> String:
	var minutes = floor(sec/60)
	var seconds = sec - (minutes * 60)
	return "%02d:%02d" % [minutes, seconds]
