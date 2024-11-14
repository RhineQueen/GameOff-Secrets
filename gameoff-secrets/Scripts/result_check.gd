extends Node

signal results_complete(correct_entries, incorrect_entries)

var correct : int
var incorrect : int

#func GAME SETUP SIGNALS
	#connect results_complete to MAIN

#func GAME CHECK RESULTS
	#split player input into an array of strings
	#Check player input strings against puzzle params(consult puzzle dict)
	#count number of correct and incorrect entries.
	#singnal results complete
