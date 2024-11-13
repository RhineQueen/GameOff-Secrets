extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_input_text_submitted(new_text: String) -> void:
	if new_text == "red yellow green blue":
		print("yes")
