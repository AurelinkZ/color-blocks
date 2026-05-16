extends Node2D

const BLOCK = preload("res://Scenes/block.tscn")
const BLOCK_TEXTURES = GameAssets.TEXTURE_BLOCKS

signal block_clicked(cell: Vector2i)

var width: int
var height: int
var grid_view: Dictionary[Vector2i, Color]

func setup_new_grid_view(grid: Dictionary, grid_width: int, grid_height: int):
	width = grid_width
	height = grid_height
	var viewport_size = get_viewport_rect().size
	var offset_x = (viewport_size.x - ((grid_width - 1 ) * GameAssets.BLOCK_SIZE)) / 2 # centered horizontally
	var offset_y = (viewport_size.y - (grid_height * GameAssets.BLOCK_SIZE)) / 2 # centered vertically
	for y in height:
		for x in width:
			var new_block = BLOCK.instantiate()
			new_block.position.x = (offset_x + GameAssets.BLOCK_SIZE * x)
			new_block.position.y = (offset_y + GameAssets.BLOCK_SIZE * y)
			new_block.block_clicked.connect(_on_block_clicked)
			new_block.set_color_first(grid[Vector2i(x, y)], BLOCK_TEXTURES)
			grid_view[Vector2i(x, y)] = grid[Vector2i(x, y)]
			add_child(new_block)
			
func _on_block_clicked(cell: Vector2i):
	block_clicked.emit(cell)
