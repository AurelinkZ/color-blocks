extends Node2D

signal block_clicked(cell: Vector2i)
var cell: Vector2i
var hover_sprite: Sprite2D
var textures: Dictionary
var is_editor: bool = false

func set_color_first(color: Color, textures_selected: Dictionary):
	textures = textures_selected
	if textures.has(color):
		set_color(color)
		
		# Setup for shadow behind the sprite
		var shadow = Sprite2D.new()
		shadow.texture = textures[color]
		shadow.position = Vector2(1.5, 1.5)
		shadow.modulate = Color(0, 0 ,0 , 0.3)
		shadow.z_index = -1
		add_child(shadow)
		
		var hover = Sprite2D.new()
		hover.texture = GameAssets.HOVER_BLOCK
		hover.z_index = 1
		hover.hide()
		hover_sprite = hover
		add_child(hover)
		hover.scale = Vector2(0, 0)
	else:
		push_warning("Color is not in the textures dictionary: ", color)

func set_color(color: Color):
	if textures.has(color):
		# Setup for the main sprite
		var sprite = $MainSprite
		sprite.texture = textures[color]
		var tween_pop = create_tween()
		tween_pop.tween_property(sprite, "scale", Vector2(1.25, 1.25), 0.05)
		tween_pop.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.05)
		
	else:
		push_warning("Color is not in the textures dictionary: ", color)
	
func set_cell(cell_nb: Vector2i):
	cell = cell_nb

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		block_clicked.emit(cell)

func _on_cursor_hover() -> void:
	# Hover UI
	AudioManager.play_hover()
	if hover_sprite != null:
		hover_sprite.show()
		var tween = create_tween()
		tween.tween_property(hover_sprite, "scale", Vector2(1.2, 1.2), 0.08)
		tween.tween_property(hover_sprite, "scale", Vector2(1.0, 1.0), 0.08)
	# Level Editor hold click to change the color of the blocks directly
	if is_editor and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print("test")
		block_clicked.emit(cell)

func _on_cursor_not_hovering() -> void:
	var tween = create_tween()
	tween.tween_property(hover_sprite, "scale", Vector2(0.0, 0.0), 0.1)
	await tween.finished
	hover_sprite.hide()

func set_editor():
	is_editor = true
