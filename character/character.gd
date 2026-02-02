extends RigidBody3D

const MOVE_SPEED := 8.0
const LINEAR_REACTION_TIME := 0.08
const ANGULAR_REACTION_TIME := 0.02

func _physics_process(delta: float) -> void:
	# move
	var dir := Vector3.ZERO
	if Input.is_action_pressed("move_frontwards"):
		dir -= Plane(Vector3.UP).project(get_viewport().get_camera_3d().global_transform.basis.z).normalized()
	if Input.is_action_pressed("move_backwards"):
		dir += Plane(Vector3.UP).project(get_viewport().get_camera_3d().global_transform.basis.z).normalized()
	if Input.is_action_pressed("move_left"):
		dir -= Plane(Vector3.UP).project(get_viewport().get_camera_3d().global_transform.basis.x).normalized()
	if Input.is_action_pressed("move_right"):
		dir += Plane(Vector3.UP).project(get_viewport().get_camera_3d().global_transform.basis.x).normalized()
	
	if dir != Vector3.ZERO:
		dir = Plane(Vector3.UP).project(dir)
		dir = dir.normalized()
		$AnimationPlayer.speed_scale = 2.0
	else:
		$AnimationPlayer.speed_scale = 1.0

	linear_velocity += (dir * MOVE_SPEED - Plane(Vector3.UP).project(linear_velocity)) * delta / LINEAR_REACTION_TIME

	# stabilize
	var angle_dir_up: Vector3 = Vector3.UP.cross(global_transform.basis.y)
	if angle_dir_up != Vector3.ZERO:
		angular_velocity += -abs(global_transform.basis.y.angle_to(Vector3.UP)) * angle_dir_up.normalized() * delta / pow(ANGULAR_REACTION_TIME, 2)
	var angle_dir_forward: Vector3 = -dir.cross(Plane(Vector3.UP).project(global_transform.basis.z))
	if angle_dir_forward != Vector3.ZERO:
		angular_velocity += abs(Plane(Vector3.UP).project(global_transform.basis.z).angle_to(dir)) * angle_dir_forward.normalized() * delta / pow(ANGULAR_REACTION_TIME, 2)
	angular_velocity += (Vector3.ZERO - angular_velocity) * delta / ANGULAR_REACTION_TIME

func tp(tr: Transform3D):
	await tp_out()
	global_transform = tr
	await get_tree().create_timer(1.0).timeout
	tp_in()

var tween:  Tween

func tp_out():
	if tween:
		tween.stop()
	freeze = true
	tween = create_tween()
	tween.tween_property($UI, "rotation:y", TAU, 0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	$UI.hide()

func tp_in():
	$AudioStreamPlayer3D.play()
	if tween:
		tween.stop()
	$UI.show()
	tween = create_tween()
	tween.tween_property($UI, "rotation:y", 0.0, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	freeze = false
