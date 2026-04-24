extends CanvasLayer

func game_won():
	$Control/Restart.hide()
	$Control/HBoxContainer.hide()
	
func game_running():
	$Control/Restart.show()
	$Control/HBoxContainer.show()
