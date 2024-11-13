extends Node

signal new_encoded(encoded_data)

var encoded_data : String

#func GAME SETUP SIGNALS
	#connect new_encoded to DATA COMPILER

#func PLAINTEXT NEW PLAINTEXT
	#Encode plaintext string with atbash cypher.
	#Run L337 replacement.
	#Signal new_encoded.
