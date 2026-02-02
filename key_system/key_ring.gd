extends Node3D

const SPACING: float = 0.75

var number: int = 0

func add(tr: Transform3D):
	var new_key_ui: Node3D = preload("res://key_system/key_ui.tscn").instantiate()
	add_child(new_key_ui)
	new_key_ui.get_node("AudioStreamPlayer3D").play()
	new_key_ui.global_transform = tr
	var tween: Tween = create_tween()
	tween.tween_property(new_key_ui, "position", number * Vector3.RIGHT * SPACING, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(new_key_ui, "rotation", Vector3.ZERO, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(new_key_ui, "scale", 0.25 * Vector3.ONE, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	number += 1

func remove(tr: Transform3D, tr_rot: Transform3D):
	number -= 1
	get_child(number).get_node("AudioStreamPlayer3D").play()
	var tween: Tween = create_tween()
	tween.tween_property(get_child(number), "global_transform", tr, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	#tween.parallel().tween_property(get_child(number), "scale", Vector3.ONE, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(get_child(number), "global_transform", tr_rot, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	#tween.parallel().tween_property(get_child(number), "global_position", tr.origin, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	tween = create_tween()
	tween.tween_property(get_child(number), "scale", 1e-2 * Vector3.ONE, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(get_child(number), "global_position", tr.origin, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(get_child(number).queue_free)
