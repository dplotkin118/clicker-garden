extends Node2D

var waterLevel: int = 0
var grown: bool = false
var breakpoints: Array = [100, 300]
var cost: int = 0

var plant_idx: int = 0
@onready var spritesheet: Sprite2D = $Sprite2D

signal sold(value: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	breakpoints = PlantInfo.plant_dict['poppy'][0]
	cost = PlantInfo.plant_dict['poppy'][1]
	print(breakpoints, cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if waterLevel >= breakpoints[0] and waterLevel < breakpoints[1]:
		spritesheet.frame = 1
	elif waterLevel >= breakpoints[1]:
		spritesheet.frame = 2
		grown = true
	else: 
		spritesheet.frame = 0

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed: 
				if !grown: 
					waterLevel += 20
					print(waterLevel)
				else:
					sold.emit(cost)
					PlantInfo.update_slot(plant_idx, "sell")
					#TODO: play animation
					self.queue_free()
