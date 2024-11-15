extends Node

signal new_plaintext(plaintext_data)

var plaintext_data : String

#func GAME SETUP SIGNALS
	#connect new_plaintext to DAATA ENCODER

#func MAIN GENERATE NEW
	#plaintext_data = get_from_storage()
	#signal new_plaintext

func get_from_storage()->String:
	#TODO determine how to distinguish what level of secret a string should be to encode appropriately
	
	#assign vars.
	var grabber: int = randi_range(0,DataStorage.text_strings.size()-1)
	var new_string = DataStorage.text_strings[grabber]
	print(new_string)
	return new_string
