extends AnimatedSprite2D

const EXPLOSION =preload("res://enemy.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	await animation_finished
	queue_free()


func _on_animation_finished() -> void:
	pass # Replace with function body.
