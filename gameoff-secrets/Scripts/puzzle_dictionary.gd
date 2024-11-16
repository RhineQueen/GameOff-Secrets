extends Node

var keyword_builder_key: Dictionary
var colour_builder_key_a: Dictionary
var colour_builder_key_b: Dictionary
var flare_builder_key_a: Dictionary
var flare_builder_key_b: Dictionary
var keyword_key: Dictionary
var colour_key: Dictionary
var flare_key: Dictionary
var equation_key: Dictionary
var atbash_key: Dictionary
var leet_key: Dictionary

func _ready() -> void:
	keyword_builder_key = {
		1:"ContVal",
		2:"PointInt",
		3:"TilReup",
		4:"CalVerr",
		5:"TeeJunct",
		6:"AwitDIL",
		7:"REZInit",
		8:"QuelFor"
	}
	
	colour_builder_key_a = {
		1:"[color=crimson]",
		2:"[color=gold]",
		3:"[color=royalblue]",
		4:"[color=limegreen]"
	}
	colour_builder_key_b = {
		1:"[/color]",
		2:"[/color]",
		3:"[/color]",
		4:"[/color]"
	}
	
	flare_builder_key_a = {
		1:"((",
		2:"{{",
		3:"[[",
		4:"<<"
	}
	flare_builder_key_b = {
		1:"))",
		2:"}}",
		3:"]]",
		4:">>"
	}
	
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
		1:"NULLrf-",
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
	
	#PROBS CUTTING EQUATIONS FOR THE JAM TIME
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
		"A":"Z",
		"B":"Y",
		"C":"X",
		"D":"W",
		"E":"V",
		"F":"U",
		"G":"T",
		"H":"S",
		"I":"R",
		"J":"Q",
		"K":"P",
		"L":"O",
		"M":"N",
		"N":"M",
		"O":"L",
		"P":"K",
		"Q":"J",
		"R":"I",
		"S":"H",
		"T":"G",
		"U":"F",
		"V":"E",
		"W":"D",
		"X":"C",
		"Y":"B",
		"Z":"A",
	}
	
	leet_key = {
		"l":"1",
		"z":"2",
		"e":"3",
		"s":"5",
		"t":"7",
		"b":"8",
		"o":"0",
		"L":"1",
		"Z":"2",
		"E":"3",
		"S":"5",
		"T":"7",
		"B":"8",
		"O":"0"
	}
