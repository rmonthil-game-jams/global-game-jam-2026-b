extends Area3D

func _on_body_entered(body: Node3D) -> void:
	get_tree().get_nodes_in_group(&"key_ring").front().add(get_node("KeyUI").global_transform)
	queue_free()
