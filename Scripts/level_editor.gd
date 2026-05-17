extends Node2D

var initial_width = 10
var initial_height = 7

var selected_color = Color.RED
var win_color: Color
@onready var grid_editor = $GridEditor
@onready var grid_view_editor = $GridViewEditor

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

func _on_grid_view_editor_block_clicked(cell: Vector2i) -> void:
	grid_editor.set_cell(cell, selected_color)
	grid_view_editor.refresh_block(cell, selected_color)

func _on_height_spin_box_value_changed(value: int) -> void:
	grid_editor.set_height(value)
	grid_view_editor.refresh_grid(grid_editor.grid, grid_editor.width, grid_editor.height)
	
func _on_width_spin_box_value_changed(value: int) -> void:
	grid_editor.set_width(value)
	grid_view_editor.refresh_grid(grid_editor.grid, grid_editor.width, grid_editor.height)

func set_spin_box_default_value():
	$UI/VBoxContainer/HBoxContainer2/HeightSpinBox.value = initial_height
	$UI/VBoxContainer/HBoxContainer/WidthSpinBox.value = initial_width


func _on_win_color_option_button_item_selected(index: int) -> void:
	win_color = INDEX_TO_COLOR[index]
	print(win_color)
