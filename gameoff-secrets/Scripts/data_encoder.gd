extends Node

signal new_encoded(encoded_data: String)

var encoded_data : String
var temp_data: String


func _on_plaintext_data_new_plaintext(plaintext_data: Array) -> void:
	temp_data = plaintext_data[0]
	#check for encoding
	match plaintext_data[1]:
		0:#plaintext, do nothing
			pass
		1:#Scovex font, break italics
			temp_data = "[i]" + temp_data
			temp_data += "[/i]"
		2:#junk data, encipher and encode
			temp_data = atbash_encypher(temp_data)
			temp_data = leet_encoder(temp_data)
	encoded_data = temp_data
	new_encoded.emit(encoded_data)

func atbash_encypher(plaintext_data)-> String:
	var to_encipher: String = plaintext_data
	var enciphered_data: String = ""
	
	#Run cypher based on rules in Puzzle Dictionary preload.
	enciphered_data = to_encipher.format(PuzzleDictionary.atbash_key,"_")
	
	print(enciphered_data)
	return enciphered_data


func leet_encoder(enciphered_data)-> String:
	var to_encode: String = enciphered_data
	var encoded_data: String = ""
	
	#Run encoder based on rules in Puzzle Dictionary preload.
	encoded_data = to_encode.format(PuzzleDictionary.leet_key,"_")
	
	print(encoded_data)
	return encoded_data
