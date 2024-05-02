extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_anim()

func play_anim() -> void:
	sprite.play('default')

func stop_anim() -> void:
	sprite.stop()