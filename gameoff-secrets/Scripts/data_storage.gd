extends Node

var text_strings_surface: Array[String]
var text_strings_shallow: Array[String]
var text_strings_deep: Array[String]
var tut_text_strings: Dictionary

func _ready() -> void:
	tut_text_strings = {
		0:"Hello! This is just a test for now![PRESS ENTER]",
		1:"Welcome to the TEST TUTORIAL![PRESS ENTER]",
		2:"Respond to: [color=crimson]((ContVal))[/color]"
	}
	
	text_strings_surface = [
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla congue est at blandit convallis. Fusce scelerisque dui in dictum accumsan. Morbi luctus eu lacus at bibendum. Vivamus urna est, dignissim vel nunc vel, fermentum auctor velit. Vestibulum et augue pulvinar, maximus eros ut, ultrices augue. Nam id placerat ante, non rutrum metus. Sed rhoncus mi non tortor malesuada, in euismod nunc porta. In et euismod lacus. Vivamus nisl justo, scelerisque nec justo at, ornare tempor arcu. In justo mauris, pretium non finibus quis, malesuada sed dui. Etiam ut magna ligula. Nunc at tellus maximus, lacinia enim in, ultrices ex. Quisque finibus augue sit amet egestas sodales. Duis semper quam quis lorem rhoncus, vel hendrerit justo tempus. Sed augue urna, faucibus vitae consequat ut, facilisis in nunc.",
		"In magna metus, aliquam sed dignissim ac, interdum porttitor lorem. Vestibulum ut lobortis nunc. Ut massa risus, bibendum ac justo nec, dignissim auctor nibh. Curabitur nec ante fringilla, auctor neque in, congue turpis. Suspendisse potenti. Donec pellentesque eu massa ut lobortis. Vivamus lacinia risus sed vestibulum dapibus. Suspendisse lacus velit, sodales in leo et, congue porta lectus. Nunc orci dui, tincidunt a viverra et, posuere non nulla. Pellentesque ut nulla nec est aliquam pharetra eget a lectus. Proin volutpat est id posuere volutpat. Vestibulum in lectus sed quam accumsan semper quis sit amet purus.",
		"Suspendisse sodales sed nisi ut ultrices. Nullam est ex, cursus sit amet ante quis, ornare ultrices eros. Aenean a auctor tortor. Curabitur ipsum augue, accumsan quis tortor vel, auctor cursus sem. Donec ullamcorper cursus purus, quis dapibus libero. Duis consectetur tempus diam, vel elementum massa tempor in. Quisque bibendum quam eget laoreet elementum."
	]
	
	text_strings_shallow = [
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla congue est at blandit convallis. Fusce scelerisque dui in dictum accumsan. Morbi luctus eu lacus at bibendum. Vivamus urna est, dignissim vel nunc vel, fermentum auctor velit. Vestibulum et augue pulvinar, maximus eros ut, ultrices augue. Nam id placerat ante, non rutrum metus. Sed rhoncus mi non tortor malesuada, in euismod nunc porta. In et euismod lacus. Vivamus nisl justo, scelerisque nec justo at, ornare tempor arcu. In justo mauris, pretium non finibus quis, malesuada sed dui. Etiam ut magna ligula. Nunc at tellus maximus, lacinia enim in, ultrices ex. Quisque finibus augue sit amet egestas sodales. Duis semper quam quis lorem rhoncus, vel hendrerit justo tempus. Sed augue urna, faucibus vitae consequat ut, facilisis in nunc.",
		"In magna metus, aliquam sed dignissim ac, interdum porttitor lorem. Vestibulum ut lobortis nunc. Ut massa risus, bibendum ac justo nec, dignissim auctor nibh. Curabitur nec ante fringilla, auctor neque in, congue turpis. Suspendisse potenti. Donec pellentesque eu massa ut lobortis. Vivamus lacinia risus sed vestibulum dapibus. Suspendisse lacus velit, sodales in leo et, congue porta lectus. Nunc orci dui, tincidunt a viverra et, posuere non nulla. Pellentesque ut nulla nec est aliquam pharetra eget a lectus. Proin volutpat est id posuere volutpat. Vestibulum in lectus sed quam accumsan semper quis sit amet purus.",
		"Suspendisse sodales sed nisi ut ultrices. Nullam est ex, cursus sit amet ante quis, ornare ultrices eros. Aenean a auctor tortor. Curabitur ipsum augue, accumsan quis tortor vel, auctor cursus sem. Donec ullamcorper cursus purus, quis dapibus libero. Duis consectetur tempus diam, vel elementum massa tempor in. Quisque bibendum quam eget laoreet elementum."
	]
	
	text_strings_deep = [
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla congue est at blandit convallis. Fusce scelerisque dui in dictum accumsan. Morbi luctus eu lacus at bibendum. Vivamus urna est, dignissim vel nunc vel, fermentum auctor velit. Vestibulum et augue pulvinar, maximus eros ut, ultrices augue. Nam id placerat ante, non rutrum metus. Sed rhoncus mi non tortor malesuada, in euismod nunc porta. In et euismod lacus. Vivamus nisl justo, scelerisque nec justo at, ornare tempor arcu. In justo mauris, pretium non finibus quis, malesuada sed dui. Etiam ut magna ligula. Nunc at tellus maximus, lacinia enim in, ultrices ex. Quisque finibus augue sit amet egestas sodales. Duis semper quam quis lorem rhoncus, vel hendrerit justo tempus. Sed augue urna, faucibus vitae consequat ut, facilisis in nunc.",
		"In magna metus, aliquam sed dignissim ac, interdum porttitor lorem. Vestibulum ut lobortis nunc. Ut massa risus, bibendum ac justo nec, dignissim auctor nibh. Curabitur nec ante fringilla, auctor neque in, congue turpis. Suspendisse potenti. Donec pellentesque eu massa ut lobortis. Vivamus lacinia risus sed vestibulum dapibus. Suspendisse lacus velit, sodales in leo et, congue porta lectus. Nunc orci dui, tincidunt a viverra et, posuere non nulla. Pellentesque ut nulla nec est aliquam pharetra eget a lectus. Proin volutpat est id posuere volutpat. Vestibulum in lectus sed quam accumsan semper quis sit amet purus.",
		"Suspendisse sodales sed nisi ut ultrices. Nullam est ex, cursus sit amet ante quis, ornare ultrices eros. Aenean a auctor tortor. Curabitur ipsum augue, accumsan quis tortor vel, auctor cursus sem. Donec ullamcorper cursus purus, quis dapibus libero. Duis consectetur tempus diam, vel elementum massa tempor in. Quisque bibendum quam eget laoreet elementum."
	]
