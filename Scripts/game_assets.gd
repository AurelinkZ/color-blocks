# Singleton to access all the assets of the game.
# Useful to get all 
extends Node

const COLOR_SELECTOR_TEXTURES = {
	Color.BLUE: [preload("res://Assets/ColorSelector/blue_selector.png"), preload("res://Assets/ColorSelector/blue_selector_selected.png")],
	Color.GREEN: [preload("res://Assets/ColorSelector/green_selector.png"), preload("res://Assets/ColorSelector/green_selector_selected.png")],
	Color.RED: [preload("res://Assets/ColorSelector/red_selector.png"), preload("res://Assets/ColorSelector/red_selector_selected.png")],
	Color.YELLOW: [preload("res://Assets/ColorSelector/yellow_selector.png"), preload("res://Assets/ColorSelector/yellow_selector_selected.png")]
}

const BLOCK_SIZE = 16
const TEXTURE_BLOCKS = {
	Color.RED: preload("res://Assets/new_blocks/new_red_block.png"),
	Color.BLUE: preload("res://Assets/new_blocks/new_blue_block.png"),
	Color.YELLOW: preload("res://Assets/new_blocks/new_yellow_block.png"),
	Color.GREEN: preload("res://Assets/new_blocks/new_green_block.png"),
	Color.WHITE: preload("res://Assets/new_blocks/white_block.png")
}

const HOVER_BLOCK = preload("res://Assets/hover.png")

const BLOCK_SIZE_OLD = 8
const TEXTURES_OLD_BLOCKS = {
	Color.RED: preload("res://Assets/Blocks/red_block.png"),
	Color.BLUE: preload("res://Assets/Blocks/blue_block.png"),
	Color.YELLOW: preload("res://Assets/Blocks/yellow_block.png"),
	Color.GREEN: preload("res://Assets/Blocks/green_block.png")
}
