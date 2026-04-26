extends Node2D

signal block_clicked(cell: Vector2i)
var cell: Vector2i

func set_color(color: Color, textures: Dictionary):
	if textures.has(color):
		# Setup for the main sprite
		var sprite = $MainSprite
		sprite.texture = textures[color]
		var tween_pop = create_tween()
		tween_pop.tween_property(sprite, "scale", Vector2(1.25, 1.25), 0.05)
		tween_pop.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.05)
		
		# Setup for shadow behind the sprite
		var shadow = Sprite2D.new()
		shadow.texture = textures[color]
		shadow.position = Vector2(1.5, 1.5)
		shadow.modulate = Color(0, 0 ,0 , 0.3)
		shadow.z_index = -1
		add_child(shadow)
	else:
		push_warning("Color is not in the textures dictionary: ", color)

func set_cell(cell_nb: Vector2i):
	cell = cell_nb

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		block_clicked.emit(cell)
