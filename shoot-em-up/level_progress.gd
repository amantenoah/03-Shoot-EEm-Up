extends Node2D

@export var enemy_scene: PackedScene
@export var enemy_container: Node
@export var parallax: Node

var triggered = false

func _process(delta):

	if triggered:
		return
	
	var camera = get_viewport().get_camera_2d()
	var scroll_progress = -parallax.scroll_offset.x
	#print(scroll_progress)

	if scroll_progress >= global_position.x:
		spawn_enemy()
		triggered = true
		set_process(false)
		
	if not camera:
		print("No Camera")
		return
		
	# When camera passes the spawner's x position
	##if camera.global_position.x >= global_position.x:
	#	print("spawned??")
	#	spawn_enemy()
	#	triggered = true


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	
	if enemy_container:
		enemy_container.add_child(enemy)
	else:
		get_tree().current_scene.add_child(enemy)
