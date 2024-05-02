extends Node

var plant_scene: Resource = load("res://scenes/plant.tscn")
var sprinkler_scene: Resource = load("res://scenes/sprinkler.tscn")
@onready var spawn_points: Node2D = $SpawnPoints
@onready var money_text: RichTextLabel = $MoneyText
@onready var dirt_container: Node2D = $DirtContainer
@onready var menu: Control = $Menu
@onready var UI_screen: Control = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerVariables.water_strength = 30
	update_dirt()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_dirt()
	if menu.visible == true:
		UI_screen.visible = false
	


func _on_plant_button_pressed() -> void:
	var plant_location: Node2D = check_open_slot()
	if plant_location != null:
		spawn_plant(PlantInfo.selected_plant, plant_location)

func _on_plant_sold(value: int) -> void:
	PlayerVariables.money += value
	money_text.text = "$$$: " + str(PlayerVariables.money)


func check_open_slot() -> Node2D:
	var level_spawn_points: Array = spawn_points.get_child(PlayerVariables.level).get_children()
	for i: int in level_spawn_points.size():
		if !level_spawn_points[i].has_plant:
			level_spawn_points[i].has_plant = true
			return level_spawn_points[i]
	return null


func spawn_plant(plant_name: String, plant_location: Node2D) -> void:
	var plant: Node2D = plant_scene.instantiate()
	plant_location.add_child(plant)
	plant.set_values(plant_name, plant_location.sprinkler)
	plant.sold.connect(_on_plant_sold)
	plant.connect("sold", Callable(plant_location, "_on_sold"))
	plant.global_position = plant_location.global_position


func update_dirt() -> void:
	var dirt_children: Array = dirt_container.get_children()
	for idx: int in dirt_children.size():
		if idx == PlayerVariables.level:
			dirt_children[idx].visible = true
		else:
			dirt_children[idx].visible = false

func _on_sprinkler_button_pressed() -> void:
	print("sprinkler")
	spawn_sprinkler()


#makes necessary updates on level up
func level_up() -> void:
	#update level
	#update plants and locations
	if PlayerVariables.level < PlayerVariables.max_level:
		PlayerVariables.level += 1
		update_spawn_locations(PlayerVariables.level)

# called on level up to update the plantable locations
func update_spawn_locations(level: int) -> void:
	var prev_level_spawn_points: Array = spawn_points.get_child(level - 1).get_children()
	var level_spawn_points: Array = spawn_points.get_child(level).get_children()
	for i: int in prev_level_spawn_points.size():
		prev_level_spawn_points[i].visible = false
		level_spawn_points[i].update_values(prev_level_spawn_points[i].get_values())
	for i: int in level_spawn_points.size():
		level_spawn_points[i].visible = true


func spawn_sprinkler() -> void:
	var level_spawn_points: Array = spawn_points.get_child(int(PlayerVariables.level)).get_children()
	for i: int in level_spawn_points.size():
		if level_spawn_points[i].sprinkler == false and level_spawn_points[i].has_plant:
				var sprinkler: Node2D = sprinkler_scene.instantiate()
				var plant: Node2D = level_spawn_points[i].get_child(2)
				plant.is_sprinkler = true
				sprinkler.global_position = Vector2(plant.global_position.x, plant.global_position.y - 100)
				level_spawn_points[i].sprinkler = true
				break

func check_open_location() -> Node2D:
	var level_spawn_points: Array = spawn_points.get_child(int(PlayerVariables.level)).get_children()
	for i: int in level_spawn_points.size():
		if level_spawn_points[i].has_plant == false:
			return level_spawn_points[i]
	return null

func _on_menu_level_up() -> void:
	if PlayerVariables.level < PlayerVariables.max_level:
		level_up()

func _on_menu_button_button_down() -> void:
	menu.visible = true