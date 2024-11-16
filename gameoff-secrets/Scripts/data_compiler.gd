extends Node

signal new_final_data(final_data)

var new_params : Array[Array]
var params_ready : bool = false
var new_encoded : String
var encoded_ready : bool = false

#func GAME SETUP SIGNALS
	#connect new_final_data to GAME

#func PUZZLEGENERATOR NEW PARAMS
	#store new params.
	#set params_ready true.
	#check if it has recieved BOTH params and encoded ready are true.
	#call compile func if so.

#func DATAENCODER NEW ENCODED
	#store new encoded.
	#set encoded_ready true.
	#check if it has recieved BOTH params and encoded ready are true.
	#call compile func if so.

#func COMPILE
	#Unset params and encoded ready bools
	#Generate BBcoded Keywords based on new_params(consult Puzzle Dictionary)
	#Split new_encoded into an array of words and insert the generated keyword into a random point in the array.
	#Convert the appended array to a string.
	#Signal new_final_data


func make_keywords(num_of_words: int):
	var new_word: String = ""
	var new_keywords: Array[String]
	var param_to_check: int = 0
	
	
	#asses params for each keyword needed and generate keyword string
	for word in num_of_words:
		param_to_check = 0
		new_word = ""
		for param in new_params[word].size():
			if new_params[word][param] != 0:
				match param_to_check:
					0:
						new_word += PuzzleDictionary.keyword_builder_key.get(new_params[word][param])
					1:
						new_word.insert(0,PuzzleDictionary.flare_builder_key.get(new_params[word][param]))#FIX THIS LATER
					2:
						new_word += PuzzleDictionary.colour_key.get(new_params[word][param])
				print(new_params[word][param])
			param_to_check += 1
		new_keywords.append(new_word)
	print(new_keywords)


func _on_test_button_pressed() -> void:
	new_params = [[1,1,1],[2,2,2],[3,3,3],[4,4,4]]
	make_keywords(new_params.size())#Number of words should be new_params.length
