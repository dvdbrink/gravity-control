extends TextureButton

const HOVER_COLOR = Color("548bc6")
const WHITE_COLOR = Color(1, 1, 1, 1)

func _on_mouse_entered():
	modulate = HOVER_COLOR


func _on_mouse_exited():
	modulate = WHITE_COLOR


func _on_pressed():
	pass
