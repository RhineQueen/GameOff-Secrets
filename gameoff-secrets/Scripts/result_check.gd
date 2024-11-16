extends Node

signal results_complete(correct_entries, incorrect_entries)

var correct : int
var incorrect : int
var final_results: Array[int]
var input_assessing_pntr: int = 0
var params_assessing_pntr: int = 0
var results: Array[bool]
#func GAME SETUP SIGNALS
	#connect results_complete to MAIN

#func CHECK RESULTS SIGNAL
	#Call check_results
	#append final_results[correct, incorrect]
	#return final_results
	
#func _on_test_button_pressed() -> void:
	#check_results("NULLrf-Var_Respec! and other things",[[1,1,1,0,0]])

func check_results(player_input:String,current_parameters:Array[Array]):
	#split player input into an array of strings
	input_assessing_pntr = 0
	params_assessing_pntr = 0
	var input_to_assess: PackedStringArray = player_input.split(" ")
	var parameters_to_assess: Array[Array] = current_parameters
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
	
	#I WOULD PUT AN EQUATION CHECKER HERE BUT I DON'T FEEL LIKE FIGURING HTAT OUT RIGHT NOW. math suxxxx Xp
