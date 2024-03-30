extends Control

func _ready():
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/map/level.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_line_edit_1_text_changed(new_text):
	GLOBAL.p1_name = new_text

func _on_line_edit_2_text_changed(new_text):
	GLOBAL.p2_name = new_text
