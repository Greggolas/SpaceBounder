extends StaticBody2D

export (PackedScene) var Dog

const MOVE_SPEED = 200
var has_dog = false


func _ready():
	if has_dog:
		var dog = Dog.instance()
		dog.position.y = position.y - 20
		var dog_facing_right = (randi() % 2) == 0
		dog.direction = 'right' if dog_facing_right else 'left'

		add_child(dog)


func _process(delta):
	position.y -= MOVE_SPEED * delta
	

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
	

func _on_start_game():
	queue_free()