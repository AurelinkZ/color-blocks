extends HBoxContainer

signal color_selected(color: Color)

const NORMAL_TEXTURE = 0
const PRESSED_TEXTURE = 1

const TEXTURE_SIZE_WIDTH = 16
const TEXTURE_SIZE_HEIGHT = 16

const TEXTURES = {
	Color.BLUE: [preload("res://Assets/ColorSelector/blue_selector.png"), preload("res://Assets/ColorSelector/blue_selector_selected.png")],
	Color.GREEN: [preload("res://Assets/ColorSelector/green_selector.png"), preload("res://Assets/ColorSelector/green_selector_selected.png")],
	Color.RED: [preload("res://Assets/ColorSelector/red_selector.png"), preload("res://Assets/ColorSelector/red_selector_selected.png")],
	Color.YELLOW: [preload("res://Assets/ColorSelector/yellow_selector.png"), preload("res://Assets/ColorSelector/yellow_selector_selected.png")]
}
var button_group = ButtonGroup.new()

func build_buttons(pallette: Array):
	for color in pallette:
		var button = TextureButton.new()
		button.texture_normal = TEXTURES[color][NORMAL_TEXTURE]
		button.texture_pressed = TEXTURES[color][PRESSED_TEXTURE]
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		button.custom_minimum_size = Vector2(TEXTURE_SIZE_WIDTH, TEXTURE_SIZE_HEIGHT)
		button.toggle_mode = true
		button.button_group = button_group
		button.pressed.connect(_on_button_pressed.bind(color))
		add_child(button)

func _on_button_pressed(color: Color) -> void:
	color_selected.emit(color)
