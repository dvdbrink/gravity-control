extends Sprite
class_name ActivePickup

var pickups: Dictionary = {
	Pickup.Type.CONTROL: {
		texture = preload("res://Assets/arrows.png"),
		scale = .4
	},
	Pickup.Type.SPEED: {
		texture = preload("res://Assets/clock.png"),
		scale = .6
	},
	Pickup.Type.ROTATE: {
		texture = preload("res://Assets/rotate.png"),
		scale = .6
	},
	Pickup.Type.TELEPORT: {
		texture = preload("res://Assets/rotate.png"),
		scale = .6
	},
	Pickup.Type.GOAL: {
		texture = preload("res://Assets/flag.png"),
		scale = .6
	}
}
var current_duration = 0

onready var icon: Sprite = $Icon
onready var timer = $Timer
onready var timerText = $Timer/Text
onready var text_update_timer = $Timer/Timer

func _ready():
	text_update_timer.connect("timeout", self, "set_timer_text")
	text_update_timer.set_one_shot(false)
	text_update_timer.set_wait_time(1)
	
	modulate = Config.Colors.INACTIVE

func set_timer_text() -> void:
	current_duration -= 1
	timerText.text = str(current_duration)

func set_pickup(pickup: int, duration: float) -> void:
	if pickups.has(pickup):
		var cfg = pickups[pickup]
		icon.texture = cfg.texture
		icon.scale = Vector2(cfg.scale, cfg.scale)
		
		timer.visible = true
		timerText.text = str(duration)
		current_duration = duration
		text_update_timer.start()
		modulate = Config.Colors.ACTIVE

func remove_pickup() -> void:
	icon.texture = null
	icon.scale = Vector2.ONE
	
	timer.visible = false
	text_update_timer.stop()
	
	modulate = Config.Colors.INACTIVE
