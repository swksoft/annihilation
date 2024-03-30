extends Control

var message_text: String

@onready var message = %Message

func _ready():
	get_tree().paused = true
	message.text = message_text

func _on_timer_timeout():
	get_tree().paused = false
	queue_free()
