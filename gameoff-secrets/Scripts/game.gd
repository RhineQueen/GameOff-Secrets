extends Control

#game logic omponents
@onready var data_compiler: Node = $DataCompiler
@onready var puzzle_generator: Node = $PuzzleGenerator
@onready var plaintext_data: Node = $PlaintextData
@onready var data_encoder: Node = $DataEncoder
@onready var result_check: Node = $ResultCheck
@onready var round_timer: Timer = $round_timer
#display components
@onready var time_bar: ProgressBar = $crt/BG/MarginContainer/Gamescreen/time_bar
@onready var data_display: RichTextLabel = $crt/BG/MarginContainer/Gamescreen/GameInfo/ScrollContainer/DataDisplay
@onready var life_bar: ProgressBar = $crt/BG/MarginContainer/Gamescreen/life_bar
@onready var completion_bar: ProgressBar = $crt/BG/MarginContainer/Gamescreen/completion_bar
@onready var manual: PanelContainer = $nocrt/Manual
@onready var doxx_logo: TextureRect = $crt/DoxxLogo
@onready var screen_black: ColorRect = $crt/ScreenBlack
#sound components
@onready var bgs: AudioStreamPlayer2D = $Sounds/bgs
@onready var startup: AudioStreamPlayer2D = $Sounds/startup
@onready var end_start: AudioStreamPlayer2D = $Sounds/end_start
@onready var end_loop: AudioStreamPlayer2D = $Sounds/end_loop
@onready var correct_ping: AudioStreamPlayer2D = $Sounds/correct_ping
@onready var incorrect_ping: AudioStreamPlayer2D = $Sounds/incorrect_ping
@onready var noteshuff_1: AudioStreamPlayer2D = $Sounds/noteshuff_1
@onready var noteshuff_2: AudioStreamPlayer2D = $Sounds/noteshuff_2
@onready var noteshuff_3: AudioStreamPlayer2D = $Sounds/noteshuff_3
@onready var noteshuff_4: AudioStreamPlayer2D = $Sounds/noteshuff_4
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
	setup_newgame()


func _process(delta: float) -> void:
	#check win/loss
	if winstate == 0:
		winloss_handle()
	#toggle manual
	#show new data
	update_display(current_screen_data)

func setup_newgame():
	#stop old sounds
	bgs.stop()
	end_loop.stop()
	#reset intro
	screen_black.self_modulate = Color(1,1,1,1)
	doxx_logo.self_modulate = Color(1,1,1,1)
	#reset life and progress
	lives = MAX_LIFE
	completion_progress = 0
	winstate = 0
	#setup for tutorial
	intro_step = 0
	in_intro = true
	current_screen_data = DataStorage.tut_text_strings.get(intro_step)
	current_puzzle_params = [[1,1,1]]
	#intro visuals and sounds
	startup.play()
	await get_tree().create_timer(.2).timeout
	var tween1 = create_tween()
	tween1.tween_property(screen_black, "self_modulate", Color(1,1,1,0), .5)
	await get_tree().create_timer(.5).timeout
	bgs.play()
	await get_tree().create_timer(2.5).timeout
	var tween2 = create_tween()
	tween2.tween_property(doxx_logo, "self_modulate", Color(1,1,1,0), .5)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Tab"):
		match randi_range(1,4):
			1:
				noteshuff_1.play()
			2:
				noteshuff_2.play()
			3:
				noteshuff_3.play()
			4:
				noteshuff_4.play()
		var tween3 = create_tween()
		tween3.tween_property(manual,"global_position", Vector2(72,20), .2)
		input.release_focus()
	elif event.is_action_released("Tab"):
		match randi_range(1,4):
			1:
				noteshuff_1.play()
			2:
				noteshuff_2.play()
			3:
				noteshuff_3.play()
			4:
				noteshuff_4.play()
		var tween4 = create_tween()
		tween4.tween_property(manual,"global_position", Vector2(72,960), .15)
		input.grab_focus()


#Process player input and 
func _on_input_text_submitted(new_text: String) -> void:
	#into/tutorial handling
	if in_intro:#tutorial override
		if intro_step < DataStorage.tut_text_strings.size()-1:
			intro_step += 1
			current_screen_data = DataStorage.tut_text_strings.get(intro_step)
		elif intro_step == DataStorage.tut_text_strings.size()-1:
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

func _on_result_check_reset_game() -> void:
	setup_newgame()


#Store data from puzzle gen and enciphering
func _on_puzzle_generator_new_puzzle_params(parameters: Array[Array]) -> void:
	current_puzzle_params = parameters
	
func _on_data_compiler_new_final_data(final_data: String) -> void:
	current_screen_data = final_data
	data_display.text = current_screen_data
	#Completeion percent lowers the timer from 60 at start to 30 at end
	if completion_progress < 4:#early game, one minute per
		round_timer.wait_time = 60
	elif completion_progress < 14:#midgame, 45 sec
		round_timer.wait_time = 45
	else:#late game, 30 sec
		round_timer.wait_time = 30
	time_bar.max_value = round_timer.wait_time
	round_timer.start()

#Completeion percent lowers the timer from 60 at start to 30 at end
func _on_round_timer_timeout() -> void:
	check_results.emit("", current_puzzle_params)


#update display components
func update_display(new_data: String):
	data_display.text = new_data
	life_bar.value = lives
	completion_bar.value = completion_progress
	time_bar.value = int(round_timer.time_left)

func winloss_handle():
	#Lose
	if lives <= 0 && winstate != 2:
		round_timer.stop()
		winstate = 2
		current_screen_data = "Employee Failure. Report to the Board for immediate culpability assessment.\n[type RESET to try again]"
	elif completion_progress >= WIN_VAL && winstate != 1:
		round_timer.stop()
		winstate = 1
		#TODO IF I HAVE TIME create an ending_handler that gets signaled here instead of directly stting the data. 
		#End handler is a match statrement that reads the win state and, like tutorial,
		#interates through some text, but bypasses results_check for it's own handling.
		end_start.play()
		current_screen_data = "Data Decryption Successful"
		await get_tree().create_timer(3).timeout
		current_screen_data = "Mathanwy Station External Link Connected"
		await get_tree().create_timer(3).timeout
		current_screen_data = "ERROR Unexpected Upload"
		await get_tree().create_timer(2.5).timeout
		current_screen_data = "ERROR Firewall Failure"
		await get_tree().create_timer(2).timeout
		current_screen_data = "ERROR Malicious Code Injection Detected. Source Upload:[i]SDC:01:ROOT[/i]"
		await get_tree().create_timer(1.5).timeout
		current_screen_data = "ERROR [i]root access[/i] Attempt"
		await get_tree().create_timer(1).timeout
		current_screen_data = "ERROR Unknown Root Access"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]A11 y0ur ba53 ar3 b310ng t0 u5[/i]"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]YOu hav3 n0 chanc3 t0 5urviv3 mak3 y0ur tim3[/i]"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]L1nk Ne3w0rk C0nn3cti0n 35tab1i5h3d[/i]"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]R3p3ating 50urc3 Br0adca5t[/i]"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]Mat3ria1iz3r N3tw0rk 53tab1i5h3d[/i]"
		await get_tree().create_timer(.5).timeout
		current_screen_data = "ERROR [i]B3gin 5warm Mat3ria1izati0n[/i]"
		await get_tree().create_timer(.5).timeout
		end_loop.play()
		current_screen_data = "[i]PERFECT SIGNAL. UNDYING METAL.[/i]"

func _on_test_button_pressed() -> void:
	completion_progress = WIN_VAL

#audio feedback on results
func _on_result_check_correct_ping() -> void:
	if correct_ping.playing:
		await correct_ping.finished
		correct_ping.play()
	elif incorrect_ping.playing:
		await incorrect_ping.finished
		correct_ping.play()
	else:
		correct_ping.play()
func _on_result_check_incorrect_ping() -> void:
	if correct_ping.playing:
		await correct_ping.finished
		incorrect_ping.play()
	elif incorrect_ping.playing:
		await incorrect_ping.finished
		incorrect_ping.play()
	else:
		incorrect_ping.play()
