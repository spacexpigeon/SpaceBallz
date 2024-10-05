extends Camera2D

# Funkcja wywoływana, gdy gra się uruchamia
func _ready():
	# Dostosuj rozmiar kamery na starcie
	adjust_camera_size()

# Funkcja do dynamicznego skalowania kamery w zależności od ekranu
func adjust_camera_size():
	var screen_size = OS.window_size  # Pobiera aktualny rozmiar ekranu (np. na telefonie)
	var base_resolution = Vector2(1280, 720)  # Bazowa rozdzielczość, do której dostosowujemy skalowanie
	var scale_factor = base_resolution / screen_size  # Oblicz współczynnik skalowania

	# Ustaw skalowanie kamery, aby dopasować się do ekranu
	zoom = scale_factor  # Zoom kamery dostosowany do wielkości ekranu

# Funkcja obsługująca zmiany rozdzielczości w trakcie gry (np. zmiana orientacji ekranu)
func _notification(what):
	if what == NOTIFICATION_RESIZED:
		adjust_camera_size()  # Dostosuj kamerę, gdy ekran się zmieni
