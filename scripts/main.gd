extends Node

var plant_scene: Resource = load("res://scenes/plant.tscn")
@onready var spawn_points: Node2D = $SpawnPoints
@onready var money_text: RichTextLabel = $MoneyText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_plant_button_pressed() -> void:
	if check_plantable(): 
		var plant: Node2D = plant_scene.instantiate()
		add_child(plant)
		plant.sold.connect(_on_plant_sold)
		plant.plant_idx = get_spawn_slot()
		plant.global_position = get_spawn_location()
		

func _on_level_up_pressed() -> void:
	if PlayerVariables.level < PlayerVariables.max_level:
		PlayerVariables.level += 1

func _on_plant_sold(value: int) -> void: 
	PlayerVariables.money += value
	money_text.text = "$$$: " + str(PlayerVariables.money)
	
func check_plantable() -> bool:
	if PlantInfo.check_open_slot(str(PlayerVariables.level)) == -1:
		return false
	else: 
		return true

func get_spawn_slot() -> int:
	var level: String = str(PlayerVariables.level)
	return PlantInfo.check_open_slot(level)

func get_spawn_location() -> Vector2:
	var spawn_point_nodes: Array[Node] = spawn_points.get_child(PlayerVariables.level).get_children()
	# var pos: Vector2 = spawn_point_nodes[PlantInfo.currently_planted].global_position
	var level: String = str(PlayerVariables.level)
	var open_slot: int = get_spawn_slot()
	print(open_slot)
	var pos: Vector2 = spawn_point_nodes[open_slot].global_position
	PlantInfo.update_slot(open_slot, "buy")
	return pos


	# clear everything on level up, finish making that work
	# add abstraction to planting 
	# ( ability to instantiate plant w different sprite sheet and have it have all right values )
	#