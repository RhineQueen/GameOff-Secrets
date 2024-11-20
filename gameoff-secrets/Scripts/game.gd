extends Control

#game logic omponents
@onready var data_compiler: Node = $DataCompiler
@onready var puzzle_generator: Node = $PuzzleGenerator
@onready var plaintext_data: Node = $PlaintextData
@onready var data_encoder: Node = $DataEncoder
@onready var result_check: Node = $ResultCheck
@onready var round_timer: Timer = $round_timer
#display components
@onready var time_bar: ProgressBar = $BG/MarginContainer/Gamescreen/time_bar
@onready var data_display: RichTextLabel = $BG/MarginContainer/Gamescreen/GameInfo/ScrollContainer/DataDisplay
@onready var life_bar: ProgressBar = $BG/MarginContainer/Gamescreen/life_bar
@onready var completion_bar: ProgressBar = $BG/MarginContainer/Gamescreen/completion_bar
@onready var manual: PanelContainer = $nocrt/Manual

#input components
@onready var input: LineEdit = $BG/MarginContainer/Gamescreen/InputArea/HBoxContainer/Input

#TODO IF I HAVE TIME add specific feedback for wrong answers

#constants
const WIN_VAL: int = 20
const MAX_LIFE: int = 10

#signals
signal setup_signals
signal generate_data(completeion_progress: int)
signal tutorial_check_results(player_input: String, puzzle_params: Array[Array])
signal check_results(player_input: String, puzzle_params: Array[Array])

#TODO IF I HAVE TIME varying winstates for varying endings
var winstate:int = 0 #0 normal, 1 win, 2 loss
var current_screen_data: String
var current_puzzle_params: Array[Array]
var in_intro: bool
var intro_step: int
var completion_progress: int
var lives: int


func _ready() -> void:
	#reset life and progress
	lives = MAX_LIFE
	completion_progress = 0
	#setup for tutorial
	intro_step = 0
	in_intro = true
	current_screen_data = DataStorage.tut_text_strings.get(intro_step)
	current_puzzle_params = [[1,1,1]]

func _process(delta: float) -> void:
	#check win/loss
	winloss_handle()
	#toggle manual
	#show new data
	update_display(current_screen_data)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Tab"):
		manual.visible = true
		input.release_focus()
	elif event.is_action_released("Tab"):
		manual.visible = false
		input.grab_focus()


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
			generate_data.emit(completion_progress)
		else:
			pass
	else :#normal gameplay
		#Process return from ResultCheck and modify game state accordingly.
		completion_progress += correct_entries
		lives -= incorrect_entries

		#Signal PlaintextData and PuzzleGenerator to trigger a new puzzle if winstate is normal.
		if winstate == 0:
			generate_data.emit(completion_progress)


#Store data from puzzle gen and enciphering
func _on_puzzle_generator_new_puzzle_params(parameters: Array[Array]) -> void:
	current_puzzle_params = parameters
	
func _on_data_compiler_new_final_data(final_data: String) -> void:
	current_screen_data = final_data
	data_display.text = current_screen_data
	round_timer.start()

#Completeion percent lowers the timer from 60 at start to 30 at end
func _on_round_timer_timeout() -> void:
	if completion_progress < 4:#early game, one minute per
		round_timer.wait_time = 60
	elif completion_progress < 14:#midgame, 45 sec
		round_timer.wait_time = 45
	else:#late game, 30 sec
		round_timer.wait_time = 30
		
	check_results.emit("", current_puzzle_params)


#update display components
func update_display(new_data: String):
	data_display.text = new_data
	life_bar.value = lives
	completion_bar.value = completion_progress
	time_bar.value = int(round_timer.time_left)

func winloss_handle():
	if lives <= 0:
		winstate = 2
		round_timer.stop()
		#check the next comment. Call the mentioned ending handler here
		input.editable = false
	
	if completion_progress >= WIN_VAL:
		winstate = 1
		round_timer.stop()
		#TODO IF I HAVE TIME create an ending_handler that gets signaled here instead of directly stting the data. 
		#End handler is a match statrement that reads the win state and, like tutorial,
		#interates through some text, but bypasses results_check for it's own handling.
		current_screen_data = "WIN TEXT HERE! YAY!"



func _on_test_button_pressed() -> void:
	current_screen_data = "THERE IS SOME TEST TEXT HERE\nAND SOME MORE TEXT HERE"
