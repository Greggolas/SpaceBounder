extends Node

export (PackedScene) var Platform

const READY_TEXT = 'GET READY'
var num_platform_locations = 5
var score

func _ready():
	randomize()
	
func _on_PlatformSpawnTimer_timeout():
	var platform_location = randi() % num_platform_locations
	var new_platform = Platform.instance()
	add_child(new_platform)
	
	if platform_location == 0:
		new_platform.position = $PlatformSpawn0.position
	if platform_location == 1:
		new_platform.position = $PlatformSpawn1.position
	if platform_location == 2:
		new_platform.position = $PlatformSpawn2.position
	if platform_location == 3:
		new_platform.position = $PlatformSpawn3.position
	if platform_location == 4:
		new_platform.position = $PlatformSpawn4.position

func _on_Player_die():
	game_over()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$PlatformSpawnTimer.start()

func _on_HUD_start_game():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$PlatformSpawnTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.spawn($PlayerSpawn.position)
	$PlatformSpawnTimer.start()
	$HUD.update_score(score)
	$HUD.show_message(READY_TEXT)
	$ScoreTimer.start()