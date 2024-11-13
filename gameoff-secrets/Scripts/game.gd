extends Control

signal setup_signals
signal generate_data
signal check_results(player_input, puzzle_params)


func _ready() -> void:
	pass
	#signal setup_signals

#func GAME SETUP SIGNALS
	#connect generate_data to PuzzleGenerator and PlaintextData
	#connect check_results to ResultCheck


func _on_input_text_submitted(new_text: String) -> void:
	pass
	#Signal ResultCheck, pass new_text and stored puzzle parameters.
	#Process return from ResultCheck and modify game state accordingly.
	#Signal PlaintextData and PuzzleGenerator to trigger a new puzzle.


#func PUZZLE GEN NEW PARAMS
	#store new params

#func DATA COMPILER NEW FINAL DATA
	#set DataDisplay text contents as new final data

#func RESULTCHECK RESULTS COMPLETE
	#update game state based on results.
