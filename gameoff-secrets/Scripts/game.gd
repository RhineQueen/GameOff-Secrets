extends Control

@onready var data_compiler: Node = $DataCompiler
@onready var puzzle_generator: Node = $PuzzleGenerator
@onready var plaintext_data: Node = $PlaintextData
@onready var data_encoder: Node = $DataEncoder
@onready var result_check: Node = $ResultCheck
@onready var data_display: RichTextLabel = $BG/MarginContainer/Gamescreen/GameInfo/DataDisplay


signal setup_signals
signal generate_data
signal check_results(player_input, puzzle_params)

var current_screen_data: String
var current_puzzle_params: Array[Array]


func _ready() -> void:
	#setup_signals.emit()
	pass

#func _on_setup_signals() -> void:
	#connect generate_data to PuzzleGenerator and PlaintextData
	#connect check_results to ResultCheck


	
func _on_input_text_submitted(new_text: String) -> void:
	pass
	#Signal ResultCheck, pass new_text and stored puzzle parameters.
	#Process return from ResultCheck and modify game state accordingly.
	#Signal PlaintextData and PuzzleGenerator to trigger a new puzzle.

func _on_puzzle_generator_new_puzzle_params(parameters: Array[Array]) -> void:
	#store new params
	current_puzzle_params = parameters
	
func _on_data_compiler_new_final_data(final_data: String) -> void:
	current_screen_data = final_data
	data_display.text = current_screen_data
	
#func PUZZLE GEN NEW PARAMS

#func DATA COMPILER NEW FINAL DATA
	#set DataDisplay text contents as new final data

#func RESULTCHECK RESULTS COMPLETE
	#update game state based on results.
