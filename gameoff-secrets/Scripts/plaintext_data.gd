extends Node

signal new_plaintext(plaintext_data: Array)

var plaintext_data: Array
var plaintext_string: String
var cipher_level: int = 0
var text_depth: int = 0


func _on_game_generate_data() -> void:
	plaintext_string = get_from_storage()
	plaintext_data = [plaintext_string, text_depth]
	new_plaintext.emit(plaintext_data)

func get_from_storage()->String:
	var grabber: int
	var new_string: String
	
	text_depth = randi_range(0,2)
	#return int 0-2 for checking in encoder. 0 - no cypher, 1 - italics(Scovex font), 2 - cipher and leet encode
	match text_depth:
		0:
			grabber = randi_range(0,DataStorage.text_strings_surface.size()-1)
			new_string = DataStorage.text_strings_surface[grabber]
		1:
			grabber = randi_range(0,DataStorage.text_strings_shallow.size()-1)
			new_string = DataStorage.text_strings_shallow[grabber]
		2:
			grabber = randi_range(0,DataStorage.text_strings_deep.size()-1)
			new_string = DataStorage.text_strings_deep[grabber]
	print(new_string)
	return new_string
