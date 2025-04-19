extends CharacterBody3D

const SPEED := 7.0
const JUMP_VELOCITY := 20.0
const GRAVITY := 50.0

var snap_vector := Vector3.DOWN

@onready var _spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var _model: Node3D = $"character-female-b2/AnimationPlayer"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get movement direction
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm_3d.rotation.y).normalized()

	if move_direction != Vector3.ZERO:
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("ui_accept")

	if is_jumping:
		velocity.y = JUMP_VELOCITY
		snap_vector = Vector3.ZERO
	elif just_landed:
		snap_vector = Vector3.DOWN

	move_and_slide() 

	if velocity.length() > 0.2:
		var look_direction = Vector2(velocity.z, velocity.x)
		_model.rotation.y = look_direction.angle()

func _process(delta: float) -> void:
	_spring_arm_3d.position = position 
