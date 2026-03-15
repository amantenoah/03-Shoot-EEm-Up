extends CharacterBody2D

var move_input: Vector2
const SPEED = 300.0


func _physics_process(delta: float) -> void:
	move_input = Input.get_vector("left","right","up",'down')
	velocity = move_input * SPEED
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


	move_and_slide()
