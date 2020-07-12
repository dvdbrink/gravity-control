extends Pickup

export(NodePath) var targetPath: NodePath

func destroy(body):
	var target = get_node(targetPath)
	target.teleported_to = true
	body.global_position = target.global_position
	.destroy(body)
