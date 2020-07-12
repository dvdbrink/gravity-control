extends KinematicBody2D
class_name Player


signal pickup_activated
signal pickup_deactivated
signal gravity_changed

const ACCELERATION: float = 1000.0
const MAX_SPEED: float = 500.0
const SPEED_MULTIPLIER: float = 2.0
const MAX_BOUNCE_SPEED: float = 1000.0
const GRAVITY: float = 500.0
const PICKUP_ACTIVATION_TIME: float = 5.0

var velocity: Vector2 = Vector2.ZERO
var gravity_direction: Vector2 = Vector2.DOWN
var active_pickup = null

onready var pickupTimer: Timer = $PickupTimer


func _ready() -> void:
	pickupTimer.connect("timeout", self, "deactivate_pickup")


func _physics_process(delta: float) -> void:
	var input = get_input_direction()
	var max_speed = get_max_speed()
	
	if get_slide_count() > 0:
		bounce()
	else:
		velocity.x += input.x * ACCELERATION * delta;
		velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if can_move_freely():
		velocity.y += input.y * ACCELERATION * delta;
		velocity.y = clamp(velocity.y, -max_speed, max_speed)
	else:
		var max_bounce_speed = get_max_bounce_speed()
		velocity.y += GRAVITY * gravity_direction.y * delta
		velocity.y = clamp(velocity.y, -max_bounce_speed, max_bounce_speed)
	
	move_and_slide(velocity)


func _on_goal_entered(body):
	queue_free()


func bounce() -> void:
	var collision = get_slide_collision(0)
	if collision != null:
		velocity = velocity.bounce(collision.normal)
		gravity_direction = Vector2(gravity_direction.x, gravity_direction.y * -1)
		emit_signal("gravity_changed", gravity_direction)


func deactivate_pickup() -> void:
	emit_signal("pickup_deactivated", active_pickup)
	active_pickup = null


func activate_pickup(pickup: int, duration: float) -> bool:
	if duration > 0:
		if pickupTimer.time_left > 0:
			return false
		pickupTimer.start(duration)
		active_pickup = pickup
	
	emit_signal("pickup_activated", pickup, duration)
	return true

func can_move_freely() -> bool:
	return active_pickup == Pickup.Type.CONTROL || active_pickup == Pickup.Type.ROTATE


func get_max_speed() -> float:
	if active_pickup == Pickup.Type.SPEED:
		return MAX_SPEED * SPEED_MULTIPLIER
	return MAX_SPEED


func get_max_bounce_speed() -> float:
	if active_pickup == Pickup.Type.SPEED:
		return MAX_BOUNCE_SPEED * SPEED_MULTIPLIER
	return MAX_BOUNCE_SPEED

func get_input_direction() -> Vector2:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()

