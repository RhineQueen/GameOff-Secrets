extends Node

signal new_final_data(final_data)

var new_params : Array[Array]
var params_ready : bool = false
var new_encoded : String
var encoded_ready : bool = false
var temp_keywords: Array[String]
var final_data: String

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
	#make_keywords(int # of words)
	#Split new_encoded into an array of words and insert the generated keyword into a random point in the array.
	#insert_keywords(keyword Array, new_encoded String)
	#Convert the appended array to a string.
	#Signal new_final_data


func make_keywords(num_of_words: int)-> Array[String]:
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
					0:#set Keyword
						new_word = PuzzleDictionary.keyword_builder_key.get(new_params[word][param]) + new_word
					1:#add Flare to front and back
						new_word = PuzzleDictionary.flare_builder_key_a.get(new_params[word][param]) + new_word
						new_word += PuzzleDictionary.flare_builder_key_b.get(new_params[word][param])
					2:#add Colour bbcode to front and back
						new_word = PuzzleDictionary.colour_builder_key_a.get(new_params[word][param]) + new_word
						new_word += PuzzleDictionary.colour_builder_key_b.get(new_params[word][param])
			param_to_check += 1
		new_keywords.append(new_word)
	
	return new_keywords


func insert_keywords(keywords: Array[String], text: String)-> String:
	var text_array: PackedStringArray = text.split(" ")
	var finalized: String
	var max_range: int = text_array.size()
	
	while keywords.size() > 0:
		#var insert_pnt: int = randi_range(1, keywords.size())
		text_array.insert(randi_range(1, max_range), keywords.pop_front())
	
	#finalize array into string and return string.
	for i in text_array:
		finalized += String(i) + " "
	return finalized



func _on_test_button_pressed() -> void:
	new_params = [[1,3,2],[2,1,0],[3,0,1],[4,2,3]]
	temp_keywords = make_keywords(new_params.size())
	final_data = insert_keywords(temp_keywords, DataStorage.text_strings.pick_random())
	print(final_data)
