extends Node

signal new_final_data(final_data: String)

var new_params : Array[Array]
var params_ready : bool = false
var new_encoded : String
var encoded_ready : bool = false
var temp_keywords: Array[String]
var final_data: String

#func GAME SETUP SIGNALS
	#connect new_final_data to GAME


func _on_puzzle_generator_new_puzzle_params(parameters: Array[Array]) -> void:
	#store new params.
	new_params = parameters
	#set params_ready true.
	params_ready = true
	#check if it has recieved BOTH params and encoded.
	if params_ready and encoded_ready:
		compile_data()


func _on_data_encoder_new_encoded(encoded_data: String) -> void:
	#store new encoded.
	new_encoded = encoded_data
	#set encoded_ready true.
	encoded_ready = true
	#check if it has recieved BOTH params and encoded.
	if params_ready and encoded_ready:
		compile_data()


func compile_data():
	#Unset params and encoded ready bools
	params_ready = false
	encoded_ready = false
	#Generate BBcoded Keywords based on new_params(consult Puzzle Dictionary)
	temp_keywords = make_keywords(new_params.size())
	#Insert keywords and return final string
	final_data = insert_keywords(temp_keywords, new_encoded)
	new_final_data.emit(final_data)


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
	
	#finalize array into string, replacing spaces, and return string.
	for i in text_array:
		finalized += String(i) + " "
	
	return finalized



#func _on_test_button_pressed() -> void:
	#new_params = [[1,3,2],[2,1,0],[3,0,1],[4,2,3]]
	#final_data = insert_keywords(temp_keywords, DataStorage.text_strings.pick_random())#should later be new_encoded instead of pick random
	#print(final_data)
