extends Node

export (PackedScene) var Platform
export (PackedScene) var Dog
export (PackedScene) var Enemy

const READY_TEXT = 'GET READY'
const DOG_ODDS = 10
var num_platform_locations = 5
var num_enemy_locations = 6
var score


func _ready():
	randomize()
	

func _on_PlatformSpawnTimer_timeout():
	var platform_location = randi() % num_platform_locations
	var new_platform = Platform.instance()
	new_platform.has_dog = (randi() % DOG_ODDS) == 0

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


func _on_EnemySpawnTimer_timeout():
	var enemy_location = randi() % num_enemy_locations
	var new_enemy = Enemy.instance()
	
	if enemy_location == 0:
		new_enemy.position = $EnemySpawn0.position
	if enemy_location == 1:
		new_enemy.position = $EnemySpawn1.position
	if enemy_location == 2:
		new_enemy.position = $EnemySpawn2.position
	if enemy_location == 3:
		new_enemy.position = $EnemySpawn3.position
	if enemy_location == 4:
		new_enemy.position = $EnemySpawn4.position
	if enemy_location == 5:
		new_enemy.position = $EnemySpawn5.position
		
	if enemy_location > (num_enemy_locations / 2) - 1:
		new_enemy.direction = 'left'
	else:
		new_enemy.direction = 'right'
	
	add_child(new_enemy)


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
	$EnemySpawnTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	$PlatformSpawnTimer.start()
	$HUD.update_score(score)
	$HUD.show_message(READY_TEXT)
	$Player.spawn($PlayerSpawn.position)
	$ScoreTimer.start()
	$EnemySpawnTimer.start()
