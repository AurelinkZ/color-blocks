extends Node

const PALETTES = {
	"easy": [Color.RED, Color.BLUE, Color.YELLOW],
	"medium": [Color.RED, Color.BLUE, Color.YELLOW, Color.GREEN]
}

var grid: Dictionary = {} #Vector2i -> color
var initial_grid: Dictionary
var height: int
var width: int
var current_pallette: Array
var target_color: Color

## Used at the start of a level
func setup(level: LevelData):
	clear_grid()
	height = level.grid_height
	width = level.grid_width
	current_pallette = PALETTES[level.difficulty]
	target_color = level.win_color
	if level.grid_data.size() != 0:
		grid = level.grid_data.duplicate()
	else:
		for i in range(0, height):
			for j in range(0, width):
				grid[Vector2i(j, i)] = pick_random_color()
	initial_grid = grid.duplicate()
	
func pick_random_color():
	return current_pallette.pick_random()
 
func fill_the_grid(cell: Vector2i, color: Color) -> Array:
	if current_pallette.has(color) == false:
		return []
	var initial_cell_color = grid[cell]
	if initial_cell_color == color:
		return 	[]
		
	var queue: Array = [cell] # The array adding all the neighbours of the actual iteration
	var visited: Dictionary # Optimisation to not go through already visited blocks
	var changed_cells: Array = []
	
	while queue.size() > 0:
		var current_cell = queue.pop_front()
		if visited.has(current_cell):
			continue
		var neighbours = check_neighbours(initial_cell_color, current_cell, visited)
		visited[current_cell] = true
		queue.append_array(neighbours)
		grid[current_cell] = color
		changed_cells.append(current_cell)
	return changed_cells
	
func check_neighbours(initial_color: Color, cell: Vector2i, visited_cells: Dictionary) -> Array:
	var directions = [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
	var neighbours_array: Array = []
	
	for dir in directions:
		var neighbour = cell + dir
		if neighbour.x >= 0 and neighbour.x < width and neighbour.y >= 0 and neighbour.y < height:
			if visited_cells.has(neighbour) != true:
				if grid[neighbour] == initial_color:
					neighbours_array.append(neighbour)
	return  neighbours_array

func restart_grid() -> void:
	grid = initial_grid.duplicate()

func is_won() -> bool:
	for color in grid.values():
		if color != target_color:
			return false
	return true

func clear_grid() -> void:
	grid.clear()
	initial_grid.clear()
