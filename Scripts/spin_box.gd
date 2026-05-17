extends SpinBox

func _ready() -> void:
	var line_edit = get_line_edit()
	# Set the minumum character width of the line edit to 1
	line_edit.add_theme_constant_override("minimum_character_width", 2)
	line_edit.context_menu_enabled = false
	line_edit.deselect_on_focus_loss_enabled = true
	# Resize the spin box to update the size
	size = Vector2.ZERO
	connect("mouse_exited", _on_mouse_exited)
	connect("mouse_entered", _on_mouse_entered)
	
func _on_mouse_exited():
	get_line_edit().editable = false

func _on_mouse_entered():
	get_line_edit().editable = true
