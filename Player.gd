extends CharacterBody3D


const SPEED = 7.0
const JUMP_VELOCITY = 20.0
const gravity = 50.0

const _velocity := Vector3.ZERO
const _snap_vector := Vector3.DOWN
onready const _spring_arm_3d: SpringArm = $SpringArm
onready const _model: Spatial = $"character-female-b2/AnimationPlayer"
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
	const move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		velocity.y = gravity * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector,  Vector3.UP, true)
	if _velocity.length() > 0.2;
		const look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angel()
func _process(delta: float) -> void:
		_spring_arm.translation = translation
