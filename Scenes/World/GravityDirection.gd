extends Sprite
class_name GravityDirection

const TWEEN_DURATION = .15

onready var arrow: Sprite = $Arrow
onready var tween: Tween = $Tween

var current_degrees

func _ready():
	current_degrees = rotation_degrees

func enable() -> void:
	modulate = Config.Colors.ACTIVE
	arrow.visible = true

func disable() -> void:
	modulate = Config.Colors.INACTIVE
	arrow.visible = false

func rotate_to(direction: Vector2, should_tween: bool = true) -> void:
	var prev_degrees = current_degrees
	var new_degrees = rad2deg(atan2(direction.y, direction.x)) + 90
	current_degrees = new_degrees
	
	tween.interpolate_property(
		arrow,
		"rotation_degrees",
		prev_degrees,
		new_degrees,
		TWEEN_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()
