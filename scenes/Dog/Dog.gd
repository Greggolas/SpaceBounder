extends Area2D

export (PackedScene) var Bullet
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 'right':
		$AnimatedSprite.flip_h = true
	
	$ShootTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ShootTimer_timeout():
	shoot()

func shoot():
	var new_bullet = Bullet.instance()
	new_bullet.direction = direction
	
	if direction == 'right':
		new_bullet.position.x += 20
	else:
		new_bullet.position.x -= 20
	
	add_child(new_bullet)
	