extends Line2D

const MAX_LENGTH = 100

export(NodePath) var targetPath
var target

func _ready():
	target = get_node(targetPath)

func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	var point = target.global_position
	add_point(point)
	while get_point_count() > MAX_LENGTH:
		remove_point(0)
