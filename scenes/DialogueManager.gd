extends Node
class_name DialogueManager

@onready var dialogue_box = self
@onready var speaker_label = dialogue_box.get_node("SpeakerLabel")
@onready var text_label = dialogue_box.get_node("TextLabel")

var lines = []
var current_line = 0
var typing = false
var text_speed = 0.02  # seconds per character

func show_dialogue(dialogue_array):
	lines = dialogue_array
	current_line = 0
	dialogue_box.visible = true
	show_next_line()

func show_next_line():
	if current_line >= lines.size():
		dialogue_box.visible = false
		return

	var line_data = lines[current_line]
	speaker_label.text = line_data.speaker
	await type_text(line_data.text)
	current_line += 1

func type_text(text):
	text_label.clear()
	typing = true
	for i in text.length():
		text_label.append_text(text[i])
		await get_tree().create_timer(text_speed).timeout
		if !typing:
			text_label.text = text  # Skip effect
			break
	typing = false

func skip_or_continue():
	if typing:
		typing = false
	else:
		show_next_line()
		
func is_end_of_dialogue() -> bool:
	return current_line >= lines.size()
