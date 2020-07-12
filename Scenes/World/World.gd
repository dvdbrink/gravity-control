extends Node2D

onready var player: Player = $Player
onready var gravityDirection: GravityDirection = $CanvasLayer/GravityDirection
onready var activePickup: ActivePickup = $CanvasLayer/ActivePickup
onready var elapsedTime: ElapsedTime = $CanvasLayer/ElapsedTime
onready var tileMap: TileMap = $TileMap
onready var tileMapTween: Tween = $TileMap/Tween

var worldRotation = 0

func _ready():
	player.connect("pickup_activated", self, "_on_pickup_activated")
	player.connect("pickup_deactivated", self, "_on_pickup_deactivated")
	player.connect("gravity_changed", self, "_on_player_gravity_changed")

func _physics_process(delta) -> void:
	if worldRotation > 0:
		tileMap.rotate(worldRotation * delta)

func _on_pickup_activated(pickup: int, duration: float) -> void:
	if duration > 0:
		activePickup.set_pickup(pickup, duration)
	
	match pickup:
		Pickup.Type.CONTROL:
			gravityDirection.disable()
		Pickup.Type.ROTATE:
			gravityDirection.disable()
			worldRotation = .25
		Pickup.Type.GOAL:
			finish()

func _on_pickup_deactivated(pickup: int) -> void:
	match pickup:
		Pickup.Type.CONTROL:
			gravityDirection.enable()
		Pickup.Type.ROTATE:
			gravityDirection.enable()
			worldRotation = 0
	
	activePickup.remove_pickup()

func _on_player_gravity_changed(direction: Vector2) -> void:
	gravityDirection.rotate_to(direction)

func finish() -> void:
	Store.save(elapsedTime.get_elapsed_seconds())
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
