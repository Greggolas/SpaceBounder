extends Node

export (PackedScene) var Platform

var num_platform_locations = 5

func _ready():
	randomize()
	$Player.spawn($PlayerSpawn.position)
	$PlatformSpawnTimer.start()
	
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
	print(new_platform.position)
	