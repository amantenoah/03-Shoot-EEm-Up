extends Area2D

var speed = 200  # Enemy's own movement speed
@export var parallax_speed_reference: Parallax2D
@export var explosion_scene: PackedScene  # Exported explosion scene

func _ready():
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	var background_speed = 0
	if parallax_speed_reference:
		background_speed = -parallax_speed_reference.scroll_speed
	
	translate(Vector2.LEFT * (speed + background_speed) * delta)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile") or area.is_in_group("player"):
		die()

func die():
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		get_parent().add_child(explosion)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("freed")
	queue_free()
