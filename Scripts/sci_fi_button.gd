extends Button
class_name SciFiButton

# --- Paramètres adaptés à une petite résolution (Pixel Art / 16x16) ---
@export var base_color: Color = Color(0.12, 0.12, 0.15, 0.95) # Gris anthracite sombre
@export var accent_color: Color = Color(1.0, 0.8, 0.0, 1.0) # Jaune "Alerte" (style Arknights)
@export var cut_corner_size: int = 4 # Petit biseau de 4 pixels
@export var font_size: int = 8 # Petite taille de police pour ne pas déformer le bouton

func _ready() -> void:
	# Taille minimale adaptée à l'échelle de vos blocs (16px de haut)
	custom_minimum_size = Vector2(48, 16)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	# Empêche le bouton de s'étirer s'il est dans un VBoxContainer ou HBoxContainer
	size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	size_flags_vertical = Control.SIZE_SHRINK_CENTER
	
	# Création dynamique des styles
	_setup_styles()
	
	# Connexion des signaux pour l'audio (utilise votre AudioManager)
	mouse_entered.connect(_on_mouse_entered)
	button_down.connect(_on_button_down)

func _setup_styles() -> void:
	# 1. STYLE NORMAL
	var style_normal = StyleBoxFlat.new()
	style_normal.bg_color = base_color
	
	# Coins coupés à 45 degrés :
	style_normal.set_corner_radius_all(0)
	style_normal.corner_radius_top_right = cut_corner_size
	style_normal.corner_radius_bottom_left = cut_corner_size
	style_normal.corner_detail = 1 # Transforme l'arrondi en biseau net
	
	# Bordure gauche fine (2px)
	style_normal.border_width_left = 2
	style_normal.border_color = accent_color
	
	# Petites marges internes pour compacter le bouton autour du texte
	style_normal.content_margin_left = 6
	style_normal.content_margin_right = 6
	style_normal.content_margin_top = 2
	style_normal.content_margin_bottom = 2
	
	# 2. STYLE SURVOL (HOVER)
	var style_hover = style_normal.duplicate()
	style_hover.bg_color = base_color.lightened(0.2)
	style_hover.border_width_bottom = 1
	style_hover.border_width_top = 1
	
	# 3. STYLE CLIQUÉ (PRESSED)
	var style_pressed = style_normal.duplicate()
	style_pressed.bg_color = accent_color
	style_pressed.border_color = Color.WHITE
	
	# Application des styles au bouton
	add_theme_stylebox_override("normal", style_normal)
	add_theme_stylebox_override("hover", style_hover)
	add_theme_stylebox_override("pressed", style_pressed)
	add_theme_stylebox_override("focus", StyleBoxEmpty.new()) # Retire le contour de sélection
	
	# Couleurs et taille du texte
	add_theme_font_size_override("font_size", font_size)
	add_theme_color_override("font_color", Color(0.9, 0.9, 0.9))
	add_theme_color_override("font_hover_color", Color.WHITE)
	add_theme_color_override("font_pressed_color", Color.BLACK)

func _on_mouse_entered() -> void:
	if AudioManager.has_method("play_hover"):
		AudioManager.play_hover()

func _on_button_down() -> void:
	if AudioManager.has_method("play_pop"):
		AudioManager.play_pop(1.0)

# Détails technologiques (Greebling) dessinés par-dessus le bouton à la bonne échelle
func _draw() -> void:
	var btn_size = get_rect().size
	
	# Petite croix en haut à gauche
	var cross_pos = Vector2(5, 4)
	var cross_size = 1.0
	draw_line(cross_pos - Vector2(cross_size, 0), cross_pos + Vector2(cross_size, 0), accent_color, 1.0)
	draw_line(cross_pos - Vector2(0, cross_size), cross_pos + Vector2(0, cross_size), accent_color, 1.0)
	
	# Petit carré de 2x2 pixels en bas à droite
	var rect_pos = Vector2(btn_size.x - 5, btn_size.y - 4)
	draw_rect(Rect2(rect_pos, Vector2(2, 2)), Color.WHITE, true)
