extends Node2D
class_name Game

const WIN_SCENE = preload("res://Scenes/win_ui.tscn")

static var edit_level_to_test: LevelData = null

@onready var grid_manager = $GridManager
@onready var grid_view = $GridView
@onready var color_selector = $UI/Control/HBoxContainer
@onready var ui = $UI

var selected_color: Color
var cells_to_animate: Array = []
var levels: Array[LevelData] = []
var index_level: int = 0

### STARTING POINT OF THE GAME.
### When launching, the game will load all the main levels and start by the first level.
### TEMPORARY WHILE THERE IS NOT A START MENU.
func _ready() -> void:
	# Normal mode
	if edit_level_to_test == null:
		_load_main_levels()
		_start_new_level(levels[index_level])
	# Edit level mode
	else:
		_start_new_level(edit_level_to_test)
		$UI/Control/GoToEditButton.show()
		

### Function used to setup the back and the front, used to first start a complete new level.
func _start_new_level(level: LevelData) -> void:
	ui.game_running()
	grid_manager.setup(level)
	grid_view.build_grid(grid_manager.grid, level.grid_width, level.grid_height)
	color_selector.build_buttons(grid_manager.current_pallette)
	ui.set_target_color_ui(level.win_color)
	
func _on_color_selected(color: Color) -> void:
	selected_color = color

## Function receiving the signal of a block clicked by the player.
func _on_grid_view_block_clicked(cell: Vector2i) -> void:
	if grid_manager.is_won() != true: # When game is won, player can't click a block
		cells_to_animate = grid_manager.fill_the_grid(cell, selected_color)
		grid_view.animate_refresh_grid(cells_to_animate, selected_color)

# Receive the signal of the restart button of the UI when the game is running.
func _on_restart_pressed() -> void:
	_restart_level()
	
 # Receive the signal of the restart button on the win UI.
func _on_restart_pressed_after_win() -> void:
	_restart_level()
	if $UI/WinUI != null:
		$UI/WinUI.queue_free()

## Main function to restart a game cleanly.
func _restart_level() -> void:
	ui.game_running()
	grid_manager.restart_grid()
	grid_view.refresh_grid(grid_manager.grid)

## Main function to show the win screen.
func _game_won():
	ui.game_won()
	var won_ui = WIN_SCENE.instantiate()
	won_ui.next_level.connect(_on_next_level_clicked)
	won_ui.restart_after_win.connect(_on_restart_pressed_after_win)
	$UI.add_child(won_ui)

func _on_next_level_clicked():
	if index_level < levels.size() - 1: 
		index_level += 1
	if levels.size() != 0:
		_start_new_level(levels[index_level]) # Avoid issues with unbound values
	
	if $UI/WinUI != null:
		$UI/WinUI.queue_free()

## Load all of the levels saved in the "Levels" folder. 
## These are the main levels created by the creator of this game.
func _load_main_levels() -> void:
	var dir_levels = DirAccess.open("res://Levels/")
	dir_levels.list_dir_begin()
	var filenames = dir_levels.get_files()
	for filename in filenames:
		levels.append(load("res://Levels/" + filename))
	dir_levels.list_dir_end()

func _on_grid_view_animation_finished() -> void:
	if grid_manager.is_won():
		_game_won()

func _on_go_to_edit_button_pressed() -> void:
	LevelEditor.edit_level_to_test = edit_level_to_test
	get_tree().change_scene_to_file("res://Scenes/level_editor.tscn")
