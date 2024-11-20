extends Node

signal new_plaintext(plaintext_data: Array)

var plaintext_data: Array
var plaintext_string: String
var text_depth: int = 0
var comp_progress: int


func _on_game_generate_data(completion_progress: int) -> void:
	comp_progress = completion_progress
	plaintext_string = get_from_storage()
	plaintext_data = [plaintext_string, text_depth]
	new_plaintext.emit(plaintext_data)

func get_from_storage()->String:
	var grabber: int
	var new_string: String
	
	
	#Completion influences text depth. More completion = more depth
	#return int 0-2 for checking in encoder. 0 - no cypher, 1 - italics(Scovex font), 2 - cipher and leet encode
	if comp_progress < 4:
		text_depth = 0
	elif comp_progress < 14:
		text_depth = randi_range(0,1)
	else:
		text_depth = randi_range(0,2)
	
	#get a random entry from the appropriate storage
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
