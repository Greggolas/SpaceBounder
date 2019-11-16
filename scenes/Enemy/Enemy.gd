extends Area2D

const MOVE_SPEED = 200
var start_postition
var screen_size
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if direction == 'right':
		position.x += MOVE_SPEED * delta
	if direction == 'left':
		position.x -= MOVE_SPEED * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()