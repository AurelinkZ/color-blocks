extends Node2D

var initial_width = 10
var initial_height = 7

@onready var grid_editor = $GridEditor
@onready var grid_view_editor = $GridViewEditor

func _ready() -> void:
	grid_editor.setup_initial_grid()
	grid_view_editor.setup_new_grid_view(grid_editor.grid, grid_editor.width, grid_editor.height)
