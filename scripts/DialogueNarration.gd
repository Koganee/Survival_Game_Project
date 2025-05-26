class_name DialogueNarration
extends Node3D

@onready var DialogueManager = $"../Head/Camera3D/CanvasLayer/DialogueBox"

func start_dialogue():
	var file = FileAccess.open("res://dialogue/dialogue_player.json", FileAccess.READ)
	var json_text = file.get_as_text()
	var dialogue_data = JSON.parse_string(json_text)

	if typeof(dialogue_data) == TYPE_ARRAY:
		DialogueManager.show_dialogue(dialogue_data)
	else:
		push_error("Failed to load dialogue JSON")

func start_dialogue_2():
	var file = FileAccess.open("res://dialogue/dialogue_player_2.json", FileAccess.READ)
	var json_text = file.get_as_text()
	var dialogue_data = JSON.parse_string(json_text)

	if typeof(dialogue_data) == TYPE_ARRAY:
		DialogueManager.show_dialogue(dialogue_data)
	else:
		push_error("Failed to load dialogue JSON")
