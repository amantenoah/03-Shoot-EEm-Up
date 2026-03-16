extends Node2D

@onready var enemy = preload("res://enemy.tscn")
@onready var timer = $Timer
@onready var enemy_container = get_node("/root/Main/Parallax2D/EnemyContainer")

func _ready():
	if timer:
		timer.start()
	
	if not enemy_container:
		print("Warning: EnemyContainer not found, using parent instead")

func _on_timer_timeout() -> void:
	var ene = enemy.instantiate()
	ene.position = position
	
	# Add to enemy container if it exists, otherwise to parent
	if enemy_container:
		enemy_container.add_child(ene)
	else:
		get_parent().add_child(ene)
