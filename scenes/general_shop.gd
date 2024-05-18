extends Button

@onready var price_text: RichTextLabel = $Sprite/CostText
var item_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_hovered():
		price_text.visible = true
		price_text.text = "[center]%s[/center]" % str(PlantInfo.items[item_name][0]) + 'g'
	else:
		price_text.visible = false
