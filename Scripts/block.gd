extends Node2D

signal block_clicked(cell: Vector2i)
var cell: Vector2i

func set_color(color: Color, textures: Dictionary):
	if textures.has(color):
		$Sprite2D.texture = textures[color]
	else:
		push_warning("Color is not in the textures dictionary: ", color)

func set_cell(cell_nb: Vector2i):
	cell = cell_nb

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		block_clicked.emit(cell)
