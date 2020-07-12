extends Node

var tracks: Array = [
	preload("res://Assets/beat01.ogg")
]

onready var player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	play()

func play():
	player.stream = tracks[0]
	player.play()

func stop():
	player.stop()
