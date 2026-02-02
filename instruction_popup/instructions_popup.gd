extends Node

const TIME_PER_CHARACTER: float = 2e-2

var has_been_open: bool = false

@onready var text_node: RichTextLabel =  find_child("RichTextLabel")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("instructions"):
		if not $PopupPanel.visible:
			$PopupPanel.popup()
			if not has_been_open:
				text_node.visible_ratio = 0.0
				create_tween().tween_property(text_node, "visible_ratio", 1.0, TIME_PER_CHARACTER * text_node.get_total_character_count())
				has_been_open = true
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			set_process(true)
	#elif event.is_action_pressed("screenshot"):
		#var image = get_viewport().get_texture().get_image()
		#var date = Time.get_datetime_string_from_system()
		#var file_name = "screenshot-" + date + ".jpg"
		#var path = "res://screenshots/" + file_name
		#var dir = DirAccess.open("res://")
		#if not dir.dir_exists("screenshots"):
			#dir.make_dir("screenshots")
		#image.save_jpg(path)
 
func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("instructions"):
		$PopupPanel.hide()
		set_process(false)

func _on_popup_panel_popup_hide() -> void:
	set_process(false)

func _on_button_spring_pressed() -> void:
	$PopupPanel.hide()
	await get_parent().get_node("Character").tp_out()
	get_parent().start("LevelSpring")

func _on_button_summer_pressed() -> void:
	$PopupPanel.hide()
	await get_parent().get_node("Character").tp_out()
	get_parent().start("LevelSummer")

func _on_button_autumn_pressed() -> void:
	$PopupPanel.hide()
	await get_parent().get_node("Character").tp_out()
	get_parent().start("LevelAutumn")

func _on_button_winter_pressed() -> void:
	$PopupPanel.hide()
	await get_parent().get_node("Character").tp_out()
	get_parent().start("LevelWinter")
