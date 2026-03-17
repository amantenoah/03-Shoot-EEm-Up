extends Area2D

var speed = 100  # Enemy's own movement speed
@export var parallax_speed_reference: Parallax2D
@export var target: CharacterBody2D
var bullet_scene: PackedScene = preload("res://Scenes/enemy_bullet_a.tscn")
const Explosion = preload("res://Scenes/boom.tscn")
var can_damage = true
var hp = 2
@onready var muzzle = $Muzzle

func _ready():
	add_to_group("enemy")
	#await get_tree().create_timer(randf_range(0.5, 2)).timeout
	await get_tree().create_timer(0.5).timeout
	if is_inside_tree():
		shoot()

func _physics_process(delta: float) -> void:
	var background_speed = 0
	if parallax_speed_reference:
		background_speed = parallax_speed_reference.scroll_speed
	
	translate(Vector2.LEFT * (speed + background_speed) * delta)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"): 
		take_damage()

func take_damage():
	hp -= 1
	var explosion = Explosion.instantiate()
	explosion.position = position
	get_parent().add_child(explosion)
	if hp <=0:
		die()
	

func die():
	set_process(false)
	set_physics_process(false)
	$AnimatedSprite2D.play("explode")

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and can_damage:
		body.take_damage(1)
		can_damage = false
		await get_tree().create_timer(0.5).timeout
		can_damage = true

func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = muzzle.global_position
	
	var player = get_tree().get_first_node_in_group("player")
	var target_pos = player.global_position
	var target_dir = muzzle.global_position.direction_to(target_pos)
	
	bullet.move_dir = target_dir
