extends KinematicBody2D

const GRAVITY = 300
const MOVE_SPEED = 400

var velocity = Vector2()
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "player_right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "player_left"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "player_up"
		$AnimatedSprite.flip_v = velocity.y > 0
	else:
		$AnimatedSprite.animation = "player_idle"
		
	position.x = clamp(position.x, 0, screen_size.x)
		
func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  MOVE_SPEED
	else:
		velocity.x = 0

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, 
	
	move_and_slide(velocity, Vector2(0, -1))