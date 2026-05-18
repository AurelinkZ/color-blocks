extends Node2D
class_name LevelEditor

static var edit_level_to_test: LevelData = null

var initial_width: int = 10
var initial_height: int = 7

var selected_color: Color = Color.RED
var win_color: Color = Color.RED
var width: int
var height: int
var max_moves: int = -1

@onready var grid_editor = $GridEditor
@onready var grid_view_editor = $GridViewEditor
@onready var color_selector = $UI/ColorSelector

const ARRAY_COLORS = [Color.RED, Color.BLUE, Color.YELLOW, Color.GREEN]

const INDEX_TO_COLOR = {
	0: Color.RED,
	1: Color.BLUE,
	2: Color.YELLOW,
	3: Color.GREEN,
	4: Color.WHITE
}

const COLOR_TO_INDEX = {
	Color.RED:    0,
	Color.BLUE:   1,
	Color.YELLOW: 2,
	Color.GREEN:  3,
	Color.WHITE:  4
}

func _ready() -> void:
	# If we load a level or we come back from testing the level
	if edit_level_to_test != null:
		width = edit_level_to_test.grid_width
		height = edit_level_to_test.grid_height
		max_moves = edit_level_to_test.max_moves
		_set_spin_box_max_moves(max_moves)
		win_color = edit_level_to_test.win_color
		_set_win_color_option_button(COLOR_TO_INDEX[win_color])
	# Else we put the default values
	else:
		width = initial_width
		height = initial_height
	set_spin_box_size_value(width, height)
	grid_editor.setup_initial_grid(edit_level_to_test, width, height)
	grid_view_editor.setup_new_grid_view(grid_editor.grid, grid_editor.width, grid_editor.height)
	color_selector.build_buttons(ARRAY_COLORS)
	

func _on_grid_view_editor_block_clicked(cell: Vector2i) -> void:
	grid_editor.set_cell(cell, selected_color)
	grid_view_editor.refresh_block(cell, selected_color)

func _on_height_spin_box_value_changed(value: int) -> void:
	grid_editor.set_height(value)
	grid_view_editor.refresh_grid(grid_editor.grid, grid_editor.width, grid_editor.height)
	height = value
	
func _on_width_spin_box_value_changed(value: int) -> void:
	grid_editor.set_width(value)
	grid_view_editor.refresh_grid(grid_editor.grid, grid_editor.width, grid_editor.height)
	width = value
	
func set_spin_box_size_value(width_val: int, height_val: int):
	$UI/LeftOptionsVBOX/VBoxContainer/HBoxContainer/WidthSpinBox.value = width_val
	$UI/LeftOptionsVBOX/VBoxContainer/HBoxContainer2/HeightSpinBoxBox.value = height_val

func _on_win_color_option_button_item_selected(index: int) -> void:
	win_color = INDEX_TO_COLOR[index]

func _on_color_selected(color: Color) -> void:
	selected_color = color

func _on_max_moves_changed(value: int) -> void:
	max_moves = value

## UI top left save button pressed to show the popup window
# We deactivate the grid while we are saving
func _on_save_button_pressed() -> void:
	$PopupSaveWindow.show()
	for block in $GridViewEditor.get_children():
		block.get_node("Area2D/CollisionShape2D").set_disabled(true)
	
func save_level(filename: String):
	create_level_data()
	
	var path = "res://Levels/" + filename + ".tres"
	ResourceSaver.save(edit_level_to_test, path)

func create_level_data():
	var level = LevelData.new()
	level.grid_width = width
	level.grid_height = height
	level.difficulty = "medium"
	level.win_color = win_color
	level.grid_data = grid_editor.grid
	level.max_moves = max_moves
	edit_level_to_test = level

func _on_try_level_pressed() -> void:
	create_level_data()
	Game.edit_level_to_test = edit_level_to_test
	get_tree().change_scene_to_file("res://Scenes/main_level_scene.tscn")
	
	
## Function used when the save button on the popup save window is pressed
## This function will save the level data with the filename given in the line edit
func _on_save_in_popup_pressed() -> void:
	save_level($PopupSaveWindow/SavePopup/VBoxContainer/LineEdit.text)
	$PopupSaveWindow.hide()
	for block in $GridViewEditor.get_children():
		block.get_node("Area2D/CollisionShape2D").set_disabled(false)

func _on_cancel_save_popup_pressed() -> void:
	$PopupSaveWindow.hide()
	for block in $GridViewEditor.get_children():
		block.get_node("Area2D/CollisionShape2D").set_disabled(false)

func _set_spin_box_max_moves(moves: int):
	$UI/LeftOptionsVBOX/VBoxContainer3/MaxMovesSpinBox.value = moves

func _set_win_color_option_button(id: int):
	$UI/LeftOptionsVBOX/VBoxContainer2/WinColorOptionButton.select(id)
	
