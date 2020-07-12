extends Node2D
class_name Pickup

enum Type {
	CONTROL,
	SPEED,
	ROTATE,
	TELEPORT,
	TELEPORT_TARGET,
	GOAL
}

export(Type) var type = Type.CONTROL
export(float) var duration = 0

func destroy(body) -> void:
	queue_free()

func _on_Area2D_body_entered(body):
	if body.activate_pickup(type, duration):
		destroy(body)
