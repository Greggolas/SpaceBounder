extends CanvasLayer

signal start_game

const PROMPT_TEXT = 'BOUND DOWN TO SURVIVE'
const GAME_OVER_TEXT = 'GAME OVER'


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

	
func show_game_over():
	show_message(GAME_OVER_TEXT)
	yield($MessageTimer, 'timeout')
	$MessageLabel.text = PROMPT_TEXT
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')


func _on_MessageTimer_timeout():
	$MessageLabel.hide()