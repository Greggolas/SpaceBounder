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
	$HighScoreLabel.show()
	$HighScoreValue.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

func set_high_score():
	if int($ScoreLabel.text) > int($HighScoreValue.text):
		$HighScoreValue.text = $ScoreLabel.text

func load_high_score(save_file):
	var save_game = File.new()
	if not save_game.file_exists(save_file):
		return # No save file exists
	
	save_game.open(save_file, File.READ)
	var save_data = parse_json(save_game.get_as_text())
	
	if save_data != null and save_data.has('high_score'):
		$HighScoreValue.text = save_data['high_score']
	
	save_game.close()

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	$HighScoreLabel.hide()
	$HighScoreValue.hide()
