extends Area2D

@export var speed: float = 200.0
@export var owner_group: String
@onready var destroy_timer : Timer = $DestroyTimer

var move_dir : Vector2

func _process(delta: float) -> void:
	translate(move_dir * speed * delta)	
	
	rotation = move_dir.angle()

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_destroy_timer_timeout():
	queue_free() # Replace with function body.
