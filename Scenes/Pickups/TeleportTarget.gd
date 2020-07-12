extends Pickup
class_name TeleportTarget

var teleported_to = false

func destroy(body):
	if teleported_to == true:
		.destroy(body)
