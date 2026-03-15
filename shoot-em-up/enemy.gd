extends Area2D

var speed = 200  # Enemy's own movement speed
var parallax_speed_reference: Parallax2D

const EXPLOSION = preload("res://explosion.tscn")

func _ready():
	add_to_group("enemy")
	# Find the Parallax2D node (adjust path as needed)
	parallax_speed_reference = get_node("/root/Main/Parallax2D")

func _process(delta: float) -> void:
	# Get current parallax scroll speed
	var background_speed = 0
	if parallax_speed_reference:
		# The negative sign accounts for direction
		background_speed = -parallax_speed_reference.scroll_speed
	
	# Enemy moves with background + its own movement
	var total_movement = Vector2.LEFT * (speed + background_speed) * delta
	translate(total_movement)
	
	# Remove when off screen
	if global_position.x < -100 or global_position.x > get_viewport().size.x + 200:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		die()
	elif area.is_in_group("player"):
		die()

func die():
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
