extends Node2D

var sprinkler: bool = false
var fertilizer: bool = false
var has_plant: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sprinkler and has_plant:
		get_node("Sprinkler").visible = true
	else: 
		get_node("Sprinkler").visible = false

func _on_sold(cost: int) -> void:
	has_plant = false

func update_values(values_array: Array) -> void:
	sprinkler = values_array[0]
	fertilizer = values_array[1]
	has_plant = values_array[2]

func get_values() -> Array:
	return [sprinkler, fertilizer, has_plant]