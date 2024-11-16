extends Node

signal results_complete(correct_entries: int, incorrect_entries: int)

var correct : int
var incorrect : int
var final_results: Array[int]
var input_assessing_pntr: int = 0
var params_assessing_pntr: int = 0
var results: Array[bool]


func _on_game_tutorial_check_results(player_input: String, puzzle_params: Array[Array]) -> void:
	pass # Replace with function body.

func _on_game_check_results(player_input: String, puzzle_params: Array[Array]) -> void:
	#split player input into an array of strings
	input_assessing_pntr = 0
	params_assessing_pntr = 0
	var input_to_assess: PackedStringArray = player_input.split(" ")
	var parameters_to_assess: Array[Array] = puzzle_params
	var results: Array[bool]
	
	#FORMATTING OF RETURNED PARAMETERS [keyword_val,colour_val,flare_val,equate_val,equate_var_val]
	
	#Check player input strings against puzzle params(consult puzzle dict)
	#check for keyword
	if input_to_assess[input_assessing_pntr].contains(PuzzleDictionary.keyword_key.get(parameters_to_assess[input_assessing_pntr][params_assessing_pntr])):
		print("GOOD keyword")
		correct += 1
	else:
		print("OOPS keyword")
		incorrect += 1
	
	#increment params assessing_pntr to assess colour
	params_assessing_pntr += 1
	#if has colour, check for colour.,
	if (parameters_to_assess[input_assessing_pntr][params_assessing_pntr]) != 0:
		if input_to_assess[input_assessing_pntr].begins_with(PuzzleDictionary.colour_key.get(parameters_to_assess[input_assessing_pntr][params_assessing_pntr])):
			print("GOOD colour")
			correct += 1
		else:
			print("OOPS colour")
			incorrect += 1
	else:
		print("NO colour")
		
	#increment params assessing_pntr to assess flare
	params_assessing_pntr += 1
	#if has flare, check for flare.,
	if (parameters_to_assess[input_assessing_pntr][params_assessing_pntr]) != 0:
		if input_to_assess[input_assessing_pntr].ends_with(PuzzleDictionary.flare_key.get(parameters_to_assess[input_assessing_pntr][params_assessing_pntr])):
			print("GOOD flare")
			correct += 1
		else:
			print("OOPS flare")
			incorrect += 1
	else:
		print("NO flare")
	
	#return results to game
	results_complete.emit(correct, incorrect)
	#I WOULD PUT AN EQUATION CHECKER HERE BUT I DON'T FEEL LIKE FIGURING HTAT OUT RIGHT NOW. math suxxxx Xp
