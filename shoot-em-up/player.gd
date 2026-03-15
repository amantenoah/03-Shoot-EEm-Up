extends CharacterBody2D

var move_input: Vector2
const SPEED = 300.0

@export var shoot_rate : float = 0.1
var last_shoot_time: float 

var bullet_scene: PackedScene = preload("res://bullet.tscn")

@onready var muzzle = $Muzzle

func _physics_process(delta: float) -> void:
	move_input = Input.get_vector("left","right","up",'down')
	velocity = move_input * SPEED


	move_and_slide()

func _shoot():
	last_shoot_time = Time.get_unix_time_from_system()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = muzzle.global_position
				
func _process(delta):
	if Input.is_action_pressed("shoot"):
		if Time.get_unix_time_from_system() - last_shoot_time > shoot_rate:
			_shoot()
			
			
