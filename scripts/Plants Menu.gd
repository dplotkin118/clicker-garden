extends Control

var plant_scene: Resource = load("res://scenes/shop_frame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_names()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_names() -> void:
	var frames: Array = []
	var frames2: Array = get_child(0).get_children()
	for i: int in frames2.size():
		if frames2[i].is_in_group('frame'):
			frames.append(frames2[i])
	print(frames)
	var keys: Array = PlantInfo.plant_dict.keys()
	for i: int in frames.size():
		frames[i].plant_name = keys[i]
		print(frames[i].plant_name)
	for i: int in frames.size():
		frames[i].get_node('Plant').texture = load(PlantInfo.plant_dict[keys[i]][2])
