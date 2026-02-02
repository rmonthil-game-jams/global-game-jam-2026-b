extends StaticBody3D

@export_node_path("StaticBody3D") var TARGET_PATH: NodePath

func _on_area_3d_body_entered(body: Node3D) -> void:
	$MeshInstance3DPortal/AudioStreamPlayer3D.play()
	body.tp(get_node(TARGET_PATH).get_node("Marker3D").global_transform)
	await get_tree().create_timer(1.25).timeout
	#get_node(TARGET_PATH).get_node("MeshInstance3DPortal/AudioStreamPlayer3D").play()
