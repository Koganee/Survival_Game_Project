class_name RadioInteraction
extends Node

@onready var radio_player = $"../../Level/Radio/Area3D/RadioPlayer"
@onready var dialogue_narration = $"../DialogueNarration"
@onready var pizza_01 = $"../Head/Camera3D/Pizza_01"
@onready var pizza_02 = $"../../Level/Pizza_02"
@onready var door_knock_player = $"../../Level/DoorKnockPlayer"
@onready var dialogue_box = $"../Head/Camera3D/CanvasLayer/DialogueBox"
@onready var portal = $"../../Level/Portal"
@onready var portal_player = $"../../Level/Portal/PortalPlayer"
@onready var radio_player_2 = $"../../Level/Radio/Area3D/RadioPlayer2"

var radio_finished = false

func activate_radio():
	if Global.radio_in_range and Input.is_action_just_pressed("interact") and radio_finished == false:
		radio_player.play()
		
func _on_radio_player_finished():
	dialogue_narration.start_dialogue_2()
	radio_finished = true

func place_pizza():
	if Global.radio_in_range and Input.is_action_just_pressed("interact") and radio_finished == true:
		pizza_01.visible = false
		pizza_02.visible = true
		door_knock_player.play()
	if Input.is_action_just_pressed("interact") and radio_finished == true:
		dialogue_box.visible = false
		
func _on_door_knock_player_finished():
	portal.visible = true
	portal_player.play()
	await get_tree().create_timer(8.0).timeout
	radio_player_2.play()
