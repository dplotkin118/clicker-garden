extends ScrollContainer

var variable: bool = true
var shop_frame: PackedScene = load("res://scenes/shop_frame.tscn")
var button_theme: Theme = preload("res://shop_frame.tres")

@onready var container: VBoxContainer = $VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (variable):
		var frame: Node = shop_frame.instantiate()
		container.add_child(frame)
		frame.position = Vector2(48, 200)
		frame.set_theme(button_theme)
		print(frame.theme)
		variable = false
