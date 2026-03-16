extends CharacterBody2D

var move_input: Vector2
const SPEED = 300.0

@export var shoot_rate : float = 0.1
var last_shoot_time: float 

var bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")

@onready var muzzle = $Muzzle
@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	move_input = Input.get_vector("left","right","up",'down')
	velocity = move_input * SPEED

	move_and_slide()

func _shoot():
	last_shoot_time = Time.get_unix_time_from_system()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_position = muzzle.global_position
	
	var mouse_pos = get_global_mouse_position()
	var mouse_dir = muzzle.global_position.direction_to(mouse_pos)
	
	bullet.move_dir = mouse_dir
				
func _process(delta):
	if Input.is_action_pressed("shoot"):
		if Time.get_unix_time_from_system() - last_shoot_time > shoot_rate:
			_shoot()
	
# Add these variables to your Player script
@export var max_health: int = 4
var health: int = 4

# Reference your sprite (make sure the name matches your scene tree)

var tex_full = preload("res://Assets/Sprites/Player/Main Ship - Base - Full health.png")
var tex_slight = preload("res://Assets/Sprites/Player/Main Ship - Base - Slight damage.png")
var tex_damaged = preload("res://Assets/Sprites/Player/Main Ship - Base - Damaged.png")
var tex_critical = preload("res://Assets/Sprites/Player/Main Ship - Base - Very damaged.png")

func take_damage(amount: int):
	health -= amount
	update_appearance()
	
	if health <= 0:
		explode()

func update_appearance():
	# We use a match statement or if/else to change the Sprite Region
	# You will need the exact coordinates from your Sprite Region editor
	match health:
		4:
			sprite.texture = tex_full
		3:
			sprite.texture = tex_slight
		2:
			sprite.texture = tex_damaged
		1:
			sprite.texture = tex_critical
			

func _input(event):
	# Using the action name you set in the Input Map
	if event.is_action_pressed("damage"):
		print("Ctrl + Right Click detected! Reducing health...")
		take_damage(1)
		
		# Optional: Print current health to the console to track the math
		print("Health is now: ", health)

func explode():
	# Here you would instance an explosion effect or reload the scene
	print("Player Exploded!")
	queue_free()
			
