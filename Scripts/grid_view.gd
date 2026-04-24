extends Node2D

const BLOCK_SCENE = preload("res://Scenes/block.tscn")
const BLOCK_SIZE = 8

var width: int
var height: int
var grid_view: Dictionary = {}
var blocks_to_animate_remaining: Array
var animate_color: Color

signal block_clicked(cell: Vector2i)
signal fill_grid_animation_finished()

const TEXTURES = {
	Color.RED: preload("res://Assets/Blocks/red_block.png"),
	Color.BLUE: preload("res://Assets/Blocks/blue_block.png"),
	Color.YELLOW: preload("res://Assets/Blocks/yellow_block.png"),
	Color.GREEN: preload("res://Assets/Blocks/green_block.png")
}

func build_grid(grid: Dictionary, grid_width: int, grid_height: int):
	delete_grid()
	width = grid_width
	height = grid_height
	var viewport_size = get_viewport_rect().size
	var offset_x = (viewport_size.x - ((grid_width-1) * BLOCK_SIZE)) / 2 # centered horizontally
	var offset_y = 20
	for y in grid_height:
		for x in grid_width:
			var new_block = BLOCK_SCENE.instantiate()
			new_block.position = Vector2(offset_x + x * BLOCK_SIZE, offset_y + y * BLOCK_SIZE)
			var cell_pos = Vector2i(x, y)
			new_block.set_color(grid[cell_pos], TEXTURES)
			new_block.set_cell(cell_pos)
			new_block.block_clicked.connect(_on_block_clicked)
			grid_view[Vector2i(x, y)] = new_block
			add_child(new_block)

func delete_grid():
	var blocks = get_children()
	if blocks != null:
		for block in blocks:
			block.queue_free()
	grid_view.clear()

func _on_block_clicked(cell: Vector2i):
	block_clicked.emit(cell)
	
func refresh_one(cell: Vector2i, color: Color):
	grid_view[cell].set_color(color, TEXTURES)
	
func animate_refresh_grid(blocks_to_change: Array, color: Color):
	if blocks_to_change.size() == 0:
		blocks_to_animate_remaining = []
		fill_grid_animation_finished.emit()
		return
	var cell = blocks_to_change.pop_front()
	blocks_to_animate_remaining = blocks_to_change
	animate_color = color
	refresh_one(cell, color)
	$"../AnimationTimer".start()

func _on_animation_timer_timeout() -> void:
	animate_refresh_grid(blocks_to_animate_remaining, animate_color)
	
func refresh_grid(grid: Dictionary):
	for cell in grid:
		grid_view[cell].set_color(grid[cell], TEXTURES)
