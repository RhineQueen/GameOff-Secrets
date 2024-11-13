extends Node

signal new_puzzle_params(parameters)

var parameters : Array[Array]
var keyword : Array[int]

func _ready() -> void:
	pass
	#connect new_puzzle_params to Main and DataCompiler

#func GAME SETUP SIGNALS
	#connect new_puzzle_params to GAME and DATA COMPILER

#func MAIN GENERATE NEW
	#Decide how many keywords are in this puzzle and what the parameters of those keywords are.
	#populate a new Keyword array and append it to the parameters array.
	#Signal new_puzzle_params
