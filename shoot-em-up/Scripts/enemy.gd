extends Area2D

var speed = 100  # Enemy's own movement speed
@export var parallax_speed_reference: Parallax2D
const Explosion = preload("res://Scenes/boom.tscn")
var can_damage = true
var hp = 2

func _ready():
	add_to_group("enemy")

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
