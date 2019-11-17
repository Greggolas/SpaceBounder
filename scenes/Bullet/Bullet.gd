extends Area2D

const MOVE_SPEED = 200
var direction


func _ready():
	pass


func _process(delta):
	if direction == 'right':
		position.x += MOVE_SPEED * delta
	if direction == 'left':
		position.x -= MOVE_SPEED * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()