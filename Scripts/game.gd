extends Node2D

const WIN_SCENE = preload("res://Scenes/win_ui.tscn")

@onready var grid_manager = $GridManager
@onready var grid_view = $GridView
@onready var color_selector = $UI/Control/HBoxContainer

var selected_color: Color
var cells_to_animate: Array = []
var levels: Array[LevelData] = []
var index_level: int = 0

func _ready() -> void:
	_load_main_levels()
	_start_new_level(levels[index_level])

func _start_new_level(level: LevelData) -> void:
	grid_manager.setup(level)
	grid_view.build_grid(grid_manager.grid, level.grid_width, level.grid_height)
	color_selector.build_buttons(grid_manager.current_pallette)
	
func _on_color_selected(color: Color) -> void:
	selected_color = color

func _on_grid_view_block_clicked(cell: Vector2i) -> void:
	cells_to_animate = grid_manager.fill_the_grid(cell, selected_color)
	grid_view.animate_refresh_grid(cells_to_animate, selected_color)
	if grid_manager.is_won():
		_game_won()
	
func _on_restart_pressed() -> void:
	grid_manager.restart_grid()
	grid_view.refresh_grid(grid_manager.grid)

func _game_won():
	var won_ui = WIN_SCENE.instantiate()
	won_ui.next_level.connect(_on_next_level_clicked)
	$UI.add_child(won_ui)

func _on_next_level_clicked(): # TODO FINISH NEXT LEVEL
	index_level += 1
	_start_new_level(levels[index_level])
	
	if $UI/WinUI != null:
		$UI/WinUI.queue_free()

func _load_main_levels() -> void:
	var dir_levels = DirAccess.open("res://Levels/")
	dir_levels.list_dir_begin()
	var filenames = dir_levels.get_files()
	for filename in filenames:
		levels.append(load("res://Levels/" + filename))
	dir_levels.list_dir_end()
