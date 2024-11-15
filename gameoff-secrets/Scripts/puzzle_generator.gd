extends Node

signal new_puzzle_params(parameters)

var parameters : Array[Array]
var keyword : Array[int]

func _ready() -> void:
	pass

#func GAME SETUP SIGNALS
	#connect new_puzzle_params to GAME and DATA COMPILER

#func MAIN GENERATE NEW PUZZLE
	#Decide how many keywords are in this puzzle based on the player's progress.(1-6)
	#Loop keyword generation for number of keywords
		#Keyword gnerator returns an int array. Append it to the parameters array.
	#Signal new_puzzle_params


func generate_keyword() -> Array[int]:
	#declare vars
	var keyword_val: int = 0
	var color_val: int = 0
	var flare_val: int = 0
	var equate_val: int = 0
	var equate_var_val: int = 0
	var key_array: Array[int]
	
	#TODO:make higher overall completion percent influence
	#the number of keywords in the puzzle and the number of modifiers on the keyword
	#for now it wil always generate one of each for testing.
	
	#Pick a Keyword value between 1 and 8. 0 is the default and used for error catching.
	keyword_val = randi_range(1,8)
	#Chance to pick a colour 0-4. 0 means no colour
	color_val = randi_range(1,4)
	#Chance to pick a flare 0-4. 0 means no flare
	flare_val = randi_range(1,4)
	#Chance to pick an equataion 0-4. 0 means no equation. 
	equate_val = randi_range(1,4)
	#If equation, decide variable value.
	if equate_val != 0:
		equate_var_val = randi_range(10,45)
	
	#set and return key_array[keyword_val,colour_val,flare_val,equate_val,equate_var_val]
	key_array = [keyword_val,color_val,flare_val,equate_val,equate_var_val]
	print(key_array)
	return key_array
