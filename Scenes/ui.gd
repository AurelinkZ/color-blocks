extends CanvasLayer

const COLOR_TO_STRING: Dictionary = {
	Color.RED: "Red",
	Color.BLUE: "Blue",
	Color.GREEN: "Green",
	Color.YELLOW: "Yellow"
}

func game_won():
	$Control/Restart.hide()
	$Control/HBoxContainer.hide()
	$Control/TargetColor.hide()
	
func game_running():
	$Control/Restart.show()
	$Control/HBoxContainer.show()
	$Control/TargetColor.show()
	
func set_target_color_ui(color: Color):
	$Control/TargetColor.text = "Target color: " + COLOR_TO_STRING[color]
