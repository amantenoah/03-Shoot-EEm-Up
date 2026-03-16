extends AnimatedSprite2D


func _ready() -> void:
	play("explode")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_finished() -> void:
	queue_free()
