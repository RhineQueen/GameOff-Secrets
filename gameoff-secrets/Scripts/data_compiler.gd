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
