extends StaticBody3D

@export var INSTRUCTION: String

func _on_area_3d_body_entered(body: Node3D) -> void:
	$MeshInstance3D/AudioStreamPlayer3D.play()
	await body.tp_out()
	get_tree().root.get_node("Game").start(INSTRUCTION)
