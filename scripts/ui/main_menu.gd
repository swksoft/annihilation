extends Control

func _ready():
	TurnManager.round = 0
	get_tree().paused = false
	%LineEdit.placeholder_text = str(TurnManager.max_round)

	%Play.grab_focus()
	
	match OS.get_name():
		"Windows":
			pass
		"macOS":
			pass
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			pass
		"Android":
			%Exit.disabled = true
		"iOS":
			%Exit.disabled = true
		"Web":
			%Exit.disabled = true

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/map/level.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_line_edit_1_text_changed(new_text):
	GLOBAL.p1_name = new_text

func _on_line_edit_2_text_changed(new_text):
	GLOBAL.p2_name = new_text

func _on_line_edit_text_changed(new_text):
	TurnManager.max_round = int(new_text)
	# FIXME: Y si agrego un 0?
