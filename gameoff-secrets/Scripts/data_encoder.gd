extends Node

signal new_encoded(encoded_data)

var encoded_data : String

#func GAME SETUP SIGNALS
	#connect new_encoded to DATA COMPILER

#func PLAINTEXT NEW PLAINTEXT
	#Encode plaintext string with atbash cypher.
	#Run L337 replacement.
	#Signal new_encoded.


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
