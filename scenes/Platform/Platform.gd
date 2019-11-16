extends StaticBody2D

const MOVE_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= MOVE_SPEED * delta
	
	
func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
