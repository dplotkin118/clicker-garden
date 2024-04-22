extends Node

#breakpoints, sell value, sprite
var plant_dict: Dictionary = {
	"poppy": [[100, 300], 30, "res://assets/poppy-Sheet.png"],
	"tomato": [[300, 800], 50, ""]
}

var currently_planted: Dictionary = {
	"0": [0],
	"1": [0, 0],
	"2": [0, 0, 0],
	"3": [0, 0, 0, 0],
}

func check_open_slot(idx: String) -> int:
	for slot: int in currently_planted[idx].size(): 
		if currently_planted[idx][slot] == 0: 
			return slot
	return -1

func update_slot(idx: int, value: String) -> void:
	if value == "sell": 
		currently_planted[str(PlayerVariables.level)][idx] = 0
	elif value == "buy": 
		currently_planted[str(PlayerVariables.level)][idx] = 1
