extends KinematicBody2D

const MOVE_SPEED = 400
const FALL_SPEED = 100

var velocity = Vector2(0,FALL_SPEED)
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):

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
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  MOVE_SPEED
	else:
		velocity.x = 0
	
	move_and_slide(velocity, Vector2(0, -1))

func spawn(pos):
	position = pos
	show()