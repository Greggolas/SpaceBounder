extends Node

export (PackedScene) var Platform
export (PackedScene) var Dog
export (PackedScene) var Enemy

const READY_TEXT = 'GET READY'
const DOG_ODDS = 10
const SAVE_GAME_FILE = 'user://savegame.save'
const PERSISTENT_GROUP = 'Persist'
var num_platform_locations = 5
var num_enemy_locations = 6
var score
var safety_buffer = 5
var current_buffer = 0


func _ready():
	$HUD.load_high_score(SAVE_GAME_FILE)
	randomize()
	

func _on_PlatformSpawnTimer_timeout():
	var platform_location = randi() % num_platform_locations
	var new_platform = Platform.instance()
	$HUD.connect("start_game", new_platform, "_on_start_game")
	
	if current_buffer < safety_buffer:
		current_buffer += 1
	else:
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
	$HUD.connect("start_game", new_enemy, "_on_start_game")
	
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
	$HUD.set_high_score()
	$HUD.show_game_over()
	current_buffer = 0
	save_game()


func new_game():
	score = 0	
	$PlatformSpawnTimer.start()
	$HUD.update_score(score)
	$HUD.show_message(READY_TEXT)
	$Player.spawn($PlayerSpawn.position)
	$ScoreTimer.start()
	$EnemySpawnTimer.start()


func save_game():
	var save_game = File.new()
	save_game.open(SAVE_GAME_FILE, File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group(PERSISTENT_GROUP)
	for i in save_nodes:
		var node_data = i.call('save');
		save_game.store_line(to_json(node_data))
	save_game.close()
