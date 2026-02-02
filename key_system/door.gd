extends StaticBody3D

func open():
	$Panel/AudioStreamPlayer3D.play()
	var tween: Tween = create_tween()
	tween.tween_property($Panel, "position:y", -6.5, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.25).timeout
	$CollisionShape3D.disabled = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	var key_ring: Node3D = get_tree().get_nodes_in_group(&"key_ring").front()
	if key_ring.number > 0:
		$Area3D.queue_free()
		await key_ring.remove($KeyUI.global_transform, $KeyUIOpen.global_transform)
		open()
