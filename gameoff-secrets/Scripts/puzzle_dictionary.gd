extends Node

var keyword_key: Dictionary
var colour_key: Dictionary
var flare_key: Dictionary
var equation_key: Dictionary
var atbash_key: Dictionary
var leet_key: Dictionary

func _ready() -> void:
	keyword_key = {
		#"ContVal"
		1:"Var_Respec",
		#"PointInt"
		2:"formatPNTR",
		#"TilReup"
		3:"DelCurrTval",
		#"CalVerr"
		4:"redo-verico",
		#"TeeJunt"
		5:"rmvSRClimit",
		#"AwitDIL"
		6:"Controls.dlaw",
		#"REZInit"
		7:"hdVcall",
		#"QuelFor"
		8:"RVFbreak"
	}
	
	colour_key = {
		#"red"
		1:"NULLrf",
		#"yellow"
		2:"XPRT_",
		#"blue"
		3:"lbd:",
		#"green"
		4:"verCON/"
	}
	
	flare_key = {
		#(())
		1:"%",
		#{{}}
		2:"|",
		#[[]]
		3:"@",
		#<<>>
		4:"^"
	}
	
	#FIGURE HOW TO CHECK EQUATIONS ELSEWHERE HAVE THIS JUST STORE THE RESULT CHECK FUCTION NAME
	equation_key = {
		#_=
		1:"comp_percent_check",
		#!+
		2:"double_subtract_check",
		#~&
		3:"add_add_check",
		#/-
		4:"multiply_add_check"
	}
	
	atbash_key = {
		"a":"z",
		"b":"y",
		"c":"x",
		"d":"w",
		"e":"v",
		"f":"u",
		"g":"t",
		"h":"s",
		"i":"r",
		"j":"q",
		"k":"p",
		"l":"o",
		"m":"n",
		"n":"m",
		"o":"l",
		"p":"k",
		"q":"j",
		"r":"i",
		"s":"h",
		"t":"g",
		"u":"f",
		"v":"e",
		"w":"d",
		"x":"c",
		"y":"b",
		"z":"a",
	}
	
	leet_key = {
		"l":"1",
		"z":"2",
		"e":"3",
		"s":"5",
		"t":"7",
		"b":"8",
		"o":"0"
	}
