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
		print("supposed to spawn")
		spawn_enemy()
		triggered = true
		set_process(false)
		
	if not camera:
		print("No Camera")
		return


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	
	var spawn_x = get_viewport_rect().size.x + 100
	var spawn_y = global_position.y
	 
	enemy.global_position = Vector2(spawn_x, spawn_y)
	
	if enemy_container:
		enemy_container.add_child(enemy)
	else:
		get_tree().current_scene.add_child(enemy)
