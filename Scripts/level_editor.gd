extends Node2D

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

func _ready() -> void:
	grid_editor.setup_initial_grid()
	grid_view_editor.setup_new_grid_view(grid_editor.grid, grid_editor.width, grid_editor.height)
	color_selector.build_buttons(ARRAY_COLORS)
	width = initial_width
	height = initial_height

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
	
func set_spin_box_default_value():
	$UI/VBoxContainer/HBoxContainer2/HeightSpinBox.value = initial_height
	$UI/VBoxContainer/HBoxContainer/WidthSpinBox.value = initial_width

func _on_win_color_option_button_item_selected(index: int) -> void:
	win_color = INDEX_TO_COLOR[index]

func _on_color_selected(color: Color) -> void:
	selected_color = color

func _on_max_moves_changed(value: int) -> void:
	max_moves = value

func _on_save_button_pressed() -> void:
	save_level(10)
	
func save_level(index_filename: int):
	var level = LevelData.new()
	level.grid_width = width
	level.grid_height = height
	level.difficulty = "medium"
	level.win_color = win_color
	level.grid_data = grid_editor.grid
	level.max_moves = max_moves
	
	var path = "res://Levels/edited_level_" + str(index_filename) + ".tres"
	ResourceSaver.save(level, path)

func _on_try_level_pressed() -> void:
	pass # Replace with function body.
