extends CanvasLayer

func game_won():
	$Control/Restart.hide()
	
func game_running():
	$Control/Restart.show()
