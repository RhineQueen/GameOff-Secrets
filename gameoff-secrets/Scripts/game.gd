extends Control

@onready var data_compiler: Node = $DataCompiler
@onready var puzzle_generator: Node = $PuzzleGenerator
@onready var plaintext_data: Node = $PlaintextData
@onready var data_encoder: Node = $DataEncoder
@onready var result_check: Node = $ResultCheck
@onready var data_display: RichTextLabel = $BG/MarginContainer/Gamescreen/GameInfo/ScrollContainer/DataDisplay

#TODO add feedback for wrong answers and progress bars for Firewall integrity(lives/ lose con) and recovery progress(completion to win con)

signal setup_signals
signal generate_data
signal tutorial_check_results(player_input: String, puzzle_params: Array[Array])
signal check_results(player_input: String, puzzle_params: Array[Array])

var current_screen_data: String
var current_puzzle_params: Array[Array]
var in_intro: bool
var intro_step: int
var completion_progress: int
var lives: int


func _ready() -> void:
	#setup for tutorial
	intro_step = 0
	in_intro = true
	current_screen_data = DataStorage.tut_text_strings.get(intro_step)
	current_puzzle_params = [[1,1,1]]

func _process(delta: float) -> void:
	update_display(current_screen_data)

#Process player input and 
func _on_input_text_submitted(new_text: String) -> void:
	#into/tutorial handling
	if in_intro:#tutorial override
		if intro_step < DataStorage.tut_text_strings.size()-1:
			intro_step += 1
			current_screen_data = DataStorage.tut_text_strings.get(intro_step)
			check_results.emit(new_text, current_puzzle_params)
		else:
			check_results.emit(new_text, current_puzzle_params)
	else:#normal gameplay
		#Signal ResultCheck, pass new_text and stored puzzle parameters.
		check_results.emit(new_text, current_puzzle_params)

func _on_result_check_results_complete(correct_entries: int, incorrect_entries: int) -> void:
	#intro handling
	if in_intro:
		if correct_entries == 3:
			in_intro = false
			generate_data.emit()
		else:
			pass
	else :#normal gameplay
		#Process return from ResultCheck and modify game state accordingly.
		completion_progress += correct_entries
		lives -= incorrect_entries
		#Signal PlaintextData and PuzzleGenerator to trigger a new puzzle.
		generate_data.emit()

#Store data from puzzle gen and enciphering
func _on_puzzle_generator_new_puzzle_params(parameters: Array[Array]) -> void:
	current_puzzle_params = parameters
	
func _on_data_compiler_new_final_data(final_data: String) -> void:
	current_screen_data = final_data
	data_display.text = current_screen_data

#update display components
func update_display(new_data: String):
	data_display.text = new_data


#func RESULTCHECK RESULTS COMPLETE
	#update game state based on results.
