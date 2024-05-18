extends Button

@onready var sprite: TextureRect = $Plant
@onready var price_text: RichTextLabel = $Plant/CostText
var hoverCanBuy: StyleBox = preload('res://styles/hoverCanBuy.tres')
var hoverNoBuy: StyleBox = preload("res://styles/hoverNoBuy.tres")
var plant_name: String

signal plant_bought(name: String)
signal not_enough_money

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_hovered():
		price_text.visible = true
		price_text.text = "[center]%s[/center]" % str(PlantInfo.plant_dict[plant_name][3]) + 'g'
		if PlantInfo.check_price(plant_name, "plant"):
			self.remove_theme_stylebox_override("hover")
			self.add_theme_stylebox_override("hover", hoverCanBuy)
		else:
			self.remove_theme_stylebox_override("hover")
			self.add_theme_stylebox_override("hover", hoverNoBuy)
	else:
		price_text.visible = false

func set_sprite(p_n: String) -> void:
	sprite.texture = load(PlantInfo.plant_dict[p_n][2])

func _on_pressed() -> void:
	if PlantInfo.check_price(plant_name, "plant"):
		plant_bought.emit(plant_name)
		self.disabled = true
	else: 
		print(plant_name)
		not_enough_money.emit()
