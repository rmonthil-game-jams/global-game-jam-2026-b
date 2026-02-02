extends Node3D

signal just_triggered_a
signal just_triggered_b

var mode: StringName = &"B"
var triggered: bool = false

func _on_area_3d_repulser_body_exited(body: Node3D) -> void:
	triggered = false

func _on_area_3d_trigger_body_entered(body: Node3D) -> void:
	if not triggered:
		if mode == &"A":
			just_triggered_a.emit()
			triggered = true
			mode = &"B"
		elif mode == &"B":
			just_triggered_b.emit()
			triggered = true
			mode = &"A"
