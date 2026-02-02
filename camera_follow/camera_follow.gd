extends Node3D

const REACTION_TIME: float = 0.25

@onready var character : RigidBody3D = get_parent().get_node("Character")

func _process(delta: float) -> void:
	global_position += (character.global_position - global_position) * delta / REACTION_TIME
