extends CharacterBody2D

const SPEED = 98

@export var cel_node: Node2D  # Referencja do węzła "Cel"
@export var label_node: Label  # Referencja do węzła "Label", który wyświetla punkty
var points = 0  # Licznik punktów

func _ready():
	# Upewnij się, że referencje do Cel i Label są ustawione
	if not cel_node or not label_node:
		print("Cel node or Label node not assigned!")
		return

	# Zainicjuj początkową wartość punktów
	label_node.text = str(points)

func _physics_process(delta):
	# Odczyt akcelerometru (na emulatorze, wartości mogą być domyślnie zerowe)
	var acc = Input.get_accelerometer()
	
	# Ustaw prędkość na podstawie wartości akcelerometru
	velocity.x = acc.x * SPEED
	velocity.y = -acc.y * SPEED
	
	# Porusz kulką
	move_and_slide()

	# Sprawdź kolizję z celem (Cel)
	if is_colliding_with_cel():
		on_collision_with_cel()

# Funkcja sprawdzająca kolizję kulki z obiektem "Cel"
func is_colliding_with_cel() -> bool:
	# Użyj global_transform, aby sprawdzić pozycje dwóch obiektów
	return global_position.distance_to(cel_node.global_position) < 20  # Zakładając małą odległość 20px dla kolizji

# Funkcja obsługująca kolizję z celem
func on_collision_with_cel():
	points += 1  # Zwiększ licznik punktów
	label_node.text = str(points)  # Aktualizuj wyświetlane punkty
	randomize_cel_position()  # Przenieś "Cel" w losową pozycję

# Funkcja losująca nową pozycję celu
func randomize_cel_position():
	var random_x = randf_range(100, 700)  # Losowy X w obszarze ekranu (np. od 100 do 700)
	var random_y = randf_range(100, 500)  # Losowy Y w obszarze ekranu (np. od 100 do 500)
	cel_node.position = Vector2(random_x, random_y)
