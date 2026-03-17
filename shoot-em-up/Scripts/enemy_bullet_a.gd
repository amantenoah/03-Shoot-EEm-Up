extends Area2D

@export var speed: float = 100.0
@export var owner_group: String
@onready var destroy_timer : Timer = $DestroyTimer
var move_dir : Vector2

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	translate(move_dir * speed * delta)	
	
	rotation = move_dir.angle()

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		queue_free()


func _on_destroy_timer_timeout():
	queue_free()
