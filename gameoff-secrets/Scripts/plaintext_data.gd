extends Node

signal new_plaintext(plaintext_data)

var plaintext_data : String
var data_storage : Array[String]

#func GAME SETUP SIGNALS
	#connect new_plaintext to DAATA ENCODER

#func MAIN GENERATE NEW
	#assign plaintext_data as a random entry from data_storage
	#signal new_plaintext
