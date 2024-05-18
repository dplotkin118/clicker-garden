extends Node2D

var waterLevel: float = 0.0
var is_sprinkler: bool = false
var cooldown: int = 120
var grown: bool = false
var breakpoints: Array = [100, 300, 350]
var cost: int = 0
var fertilizer: float = 1.0
var curr_name: String = ""

var plant_idx: int = 0
@onready var spritesheet: Sprite2D = $Sprite2D

signal sold(value: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	breakpoints = PlantInfo.plant_dict['poppy'][0]
	cost = PlantInfo.plant_dict['poppy'][1]
	print(breakpoints, cost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if waterLevel >= breakpoints[0] and waterLevel < breakpoints[1]:
		spritesheet.frame = 1
	elif waterLevel >= breakpoints[1] and waterLevel < breakpoints[2]:
		spritesheet.frame = 2
	elif waterLevel >= breakpoints[2]:
		grown = true
	else: 
		spritesheet.frame = 0

	if grown: 
		sell()

	if is_sprinkler:
		cooldown -= delta
		if cooldown <= 0:
			waterLevel += 10
			cooldown = 120
	
	if get_parent().sprinkler: 
		is_sprinkler = true


func set_values(plant_name: String, sprinkler: bool = false) -> void:
	self.is_sprinkler = sprinkler
	self.cost = PlantInfo.plant_dict[plant_name][1]
	self.breakpoints = PlantInfo.plant_dict[plant_name][0]
	self.curr_name = plant_name

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed: 
				if !grown: 
					waterLevel += (PlayerVariables.water_strength * fertilizer)
					print(waterLevel)
				else:
					sell()

func sell() -> void:
	sold.emit(cost)
	#TODO: play animation
	self.queue_free()