extends Node

const INITIAL_WIDTH: int = 10
const INITIAL_HEIGHT: int = 6

var width: int = INITIAL_WIDTH
var height: int = INITIAL_HEIGHT
var grid: Dictionary # Vector2i -> Color (Example: Vector2i(0, 0) -> Color.WHITE)

## Function to use to initialise the first grid of the level editor
# Every cell of the grid will be blank (Color.WHTIE)
func setup_initial_grid():
	for y in height:
		for x in width:
			grid[Vector2i(x, y)] = Color.WHITE

## Set the width and refreshes the grid directly
func set_width(width_user: int):
	width = width_user
	refresh_grid()

## Set the height and refreshes the grid directly
func set_height(height_user: int):
	height = height_user
	refresh_grid()

## Used to refresh the grid after changing the size of the grid
# The function saves the block color already placed, if no colors has been placed then we will put Color.WHITE
func refresh_grid():
	var new_grid: Dictionary
	for y in height:
		for x in width:
			var current_coord = Vector2i(x, y)
			if grid.has(current_coord):
				new_grid[current_coord] = grid[current_coord]
			else:
				new_grid[current_coord] = Color.WHITE
	grid = new_grid.duplicate()

# Use this function when the user change a block.
func set_cell(cell: Vector2i, color: Color):
	if GameAssets.TEXTURE_BLOCKS.has(color):
		grid[cell] = color

func get_cell_color(cell: Vector2i):
	return grid[cell]
