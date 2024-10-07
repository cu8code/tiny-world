extends CharacterBody3D

@onready var camera := $shape/head/camera
@onready var head := $shape/head
@export var speed: float = 40.0
@export var gravity: float = 5.0
@export var rlimit_x:= deg_to_rad(45)

var dir: Vector2 = Vector2.ZERO
var rdir: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Capture the mouse for a more immersive experience
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	# Handle movement input
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	
	# Handle mouse motion for camera rotation
	if event is InputEventMouseMotion:
		rdir = event.relative.normalized()
	
	# Handle input for toggling mouse visibility
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	if rdir != Vector2.ZERO:
		camera.rotate_x(-rdir.y * delta)
		head.rotate_y(-rdir.x * delta)
		rdir = Vector2.ZERO
	
	camera.rotation.x = clamp(camera.rotation.x, -rlimit_x, rlimit_x)
	
	# Update character velocity based on input and gravity
	if is_on_floor_only():
		var res = (camera.global_transform.basis * Vector3(dir.x, 0, dir.y)).normalized() * speed * delta
		velocity = res
	else:
		velocity.y -= gravity * delta  # Apply gravity continuously
	
	move_and_slide()
