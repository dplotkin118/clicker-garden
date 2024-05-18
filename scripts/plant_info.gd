extends Node

var selected_plant: String = "poppy"
var owned_plants: Array = ["poppy"]

#breakpoints, sell value, sprite, price
var plant_dict: Dictionary = {
	"poppy": [[100, 300, 350], 30, "res://assets/poppy.png", 0],
	"tomato": [[300, 800, 850], 50, "res://assets/tomato.png", 100],
	"carrot": [[300, 800, 850], 50, "", 200],
	"pea": [[300, 800, 850], 50, "", 500],
	"apple": [[300, 800, 850], 50, "", 1000],
	"lemon": [[300, 800, 850], 50, "", 2000],
	"mushroom": [[300, 800, 850], 50, "", 3000],
	"banana": [[300, 800, 850], 50, "", 5000],
	"radish": [[300, 800, 850], 50, "", 10000],
	"chrysanthemum": [[300, 800, 850], 50, "", 15000],
	"sauce": [[300, 800, 850], 50, "", 50000]
}

#price
var items: Dictionary = {
	"sprinkler": [1500],
}

func get_cost(name: String, type: String) -> int:
	if type == "plant":
		return plant_dict[name][3]
	else:
		return items[name][0]

func check_price(plant_name: String, type: String) -> bool:
	if get_cost(plant_name, type) > PlayerVariables.money:
		return false
	else: 
		return true
