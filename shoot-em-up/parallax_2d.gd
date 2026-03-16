extends Parallax2D

@export var scroll_speed = 500
@export var level_length = 4450

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll_offset.x = max(scroll_offset.x - scroll_speed * delta, -level_length)
