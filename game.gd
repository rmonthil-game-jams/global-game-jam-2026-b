extends Node

var init_current_level_y: float
var current_level: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Character/UI.hide()
	$Character/UI.rotation.y = TAU
	$Character.freeze = true
	await get_tree().create_timer(1.0).timeout
	start("LevelSpring")

func start(instruction: String):
	match instruction:
		"LevelSpring":
			if current_level:
				var tween: Tween = create_tween()
				tween.tween_property(current_level, "position:y", init_current_level_y, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
				await tween.finished
				current_level.queue_free()
			# audio start
			$AudioStreamPlayerSpring.volume_db = 0
			$AudioStreamPlayerSummer.volume_db = -80
			$AudioStreamPlayerAutumn.volume_db = -80
			# audio end
			current_level = preload("res://level_spring.tscn").instantiate()
			current_level.position.y = -2.8
			add_child(current_level)
			$Character.global_transform = current_level.get_node("StartingTransform").global_transform
			current_level.position.y = -16.0
			init_current_level_y = current_level.position.y
			var tween: Tween = create_tween()
			tween.tween_property(current_level, "position:y", -2.8, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			$Character.tp_in()
		"LevelSummer":
			if current_level:
				var tween: Tween = create_tween()
				tween.tween_property(current_level, "position:y", init_current_level_y, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
				await tween.finished
				current_level.queue_free()
			# audio start
			$AudioStreamPlayerSpring.volume_db = -80
			$AudioStreamPlayerSummer.volume_db = 0
			$AudioStreamPlayerAutumn.volume_db = -80
			# audio end
			current_level = preload("res://level_summer.tscn").instantiate()
			current_level.position.y = 18.4
			add_child(current_level)
			$Character.global_transform = current_level.get_node("StartingTransform").global_transform
			current_level.position.y = -15.0
			init_current_level_y = current_level.position.y
			var tween: Tween = create_tween()
			tween.tween_interval(1.0)
			tween.tween_property(current_level, "position:y", 18.4, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			$Character.tp_in()
		"LevelAutumn":
			if current_level:
				var tween: Tween = create_tween()
				tween.tween_property(current_level, "position:y", init_current_level_y, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
				await tween.finished
				current_level.queue_free()
			# audio start
			$AudioStreamPlayerSpring.volume_db = -80
			$AudioStreamPlayerSummer.volume_db = -80
			$AudioStreamPlayerAutumn.volume_db = 0
			# audio end
			current_level = preload("res://level_autumn.tscn").instantiate()
			current_level.position.y = -1
			add_child(current_level)
			$Character.global_transform = current_level.get_node("StartingTransform").global_transform
			current_level.position.y = -16.0
			init_current_level_y = current_level.position.y
			var tween: Tween = create_tween()
			tween.tween_interval(1.0)
			tween.tween_property(current_level, "position:y", -1, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
			$Character.tp_in()
		"LevelWinter":
			if current_level:
				var tween: Tween = create_tween()
				tween.tween_property(current_level, "position:y", init_current_level_y, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
				await tween.finished
				current_level.queue_free()
			current_level = preload("res://level_winter.tscn").instantiate()
			current_level.position.y = -2.0
			init_current_level_y = current_level.position.y
			add_child(current_level)
			$Character.global_position = Vector3(0.0, 1.0, 0.0) # controls camera
			var tween: Tween = create_tween()
			tween.tween_interval(1.0)
			tween.tween_property(current_level, "position:y", 0.0, 2.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
			await tween.finished
