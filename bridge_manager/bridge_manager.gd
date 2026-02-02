extends Node

const BRIDGE_SPEED: float = 4.0

@export_node_path("Node3D") var PRESSURE_PLATE_PATH: NodePath
@export_node_path("Node3D") var MARKER_A_PATH: NodePath
@export_node_path("Node3D") var MARKER_B_PATH: NodePath
@export_node_path("StaticBody3D") var WALL_A_PATH: NodePath
@export_node_path("StaticBody3D") var WALL_B_PATH: NodePath
@export_node_path("AnimatableBody3D") var BRIDGE_PATH: NodePath

func _ready() -> void:
	get_node(PRESSURE_PLATE_PATH).just_triggered_a.connect(_on_just_triggered_a)
	get_node(PRESSURE_PLATE_PATH).just_triggered_b.connect(_on_just_triggered_b)

var tween: Tween
func _on_just_triggered_a():
	# close path
	for child in get_node(WALL_A_PATH).get_children():
		if child is CollisionShape3D:
			child.disabled = false
	# move bridge
	if tween:
		tween.stop()
	var bridge: AnimatableBody3D = get_node(BRIDGE_PATH)
	bridge.get_node("AudioStreamPlayer3D").play()
	tween = create_tween()
	var distance: float = bridge.global_position.distance_to(get_node(MARKER_B_PATH).global_position)
	tween.tween_property(bridge, "global_position", get_node(MARKER_B_PATH).global_position, distance/BRIDGE_SPEED).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(bridge.get_node("AudioStreamPlayer3D").stop)
	await get_tree().create_timer(0.75 * distance/BRIDGE_SPEED).timeout
	for child in get_node(WALL_B_PATH).get_children():
		if child is CollisionShape3D:
			child.disabled = true

func _on_just_triggered_b():
	# close path
	for child in get_node(WALL_B_PATH).get_children():
		if child is CollisionShape3D:
			child.disabled = false
	# move bridge
	if tween:
		tween.stop()
	var bridge: AnimatableBody3D = get_node(BRIDGE_PATH)
	bridge.get_node("AudioStreamPlayer3D").play()
	tween = create_tween()
	var distance: float = bridge.global_position.distance_to(get_node(MARKER_A_PATH).global_position)
	tween.tween_property(bridge, "global_position", get_node(MARKER_A_PATH).global_position, distance/BRIDGE_SPEED).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(bridge.get_node("AudioStreamPlayer3D").stop)
	await get_tree().create_timer(0.75 * distance/BRIDGE_SPEED).timeout
	for child in get_node(WALL_A_PATH).get_children():
		if child is CollisionShape3D:
			child.disabled = true
