extends Control

signal level_up
signal sprinkler_bought

@onready var plants_menu: Control = $"Plants Menu"
@onready var main_menu: Control = $"Main Menu"
@onready var shop_menu: Control = $"Shop Menu"
@onready var not_enough: RichTextLabel = $"Plants Menu/Not Enough Money"
@onready var money_text: RichTextLabel = $"MoneyText"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var frames: Array = []
	var frames2: Array = plants_menu.get_child(0).get_children()
	for i: int in frames2.size():
		if frames2[i].is_in_group('frame'):
			frames.append(frames2[i])
	for i: int in frames.size():
		frames[i].plant_bought.connect(_on_plant_bought)
		frames[i].not_enough_money.connect(_on_not_enough_money)

#on load, get all plant items and connect signals

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	money_text.text = str(PlayerVariables.money)


func _on_level_pressed() -> void:
	level_up.emit()


func _on_plants_menu_back_button_pressed() -> void:
	main_menu.visible = true
	plants_menu.visible = false


func _on_plants_button_pressed() -> void:
	plants_menu.visible = true
	main_menu.visible = false


func _on_main_menu_back_button_pressed() -> void:
	visible = false


func _on_shop_menu_back_button_pressed() -> void:
	shop_menu.visible = false
	main_menu.visible = true


func _on_sprinkler_pressed() -> void:
	if PlantInfo.check_price('sprinkler', "item"):
		sprinkler_bought.emit()


func _on_shop_pressed() -> void:
	shop_menu.visible = true
	main_menu.visible = false


func _on_menu_button_button_down() -> void:
	main_menu.visible = true
	plants_menu.visible = false
	shop_menu.visible = false

func _on_plant_bought(plant_name: String) -> void:
	if PlantInfo.check_price(plant_name, "plant"):
		print("arpeplw")
		PlantInfo.owned_plants.append(plant_name)

func _on_not_enough_money() -> void:
	print("not enough")
	not_enough.visible = true
	await get_tree().create_timer(.5).timeout
	not_enough.visible = false
