class_name DoorInteraction
extends Node

@onready var door_knock_player = $DoorKnockPlayer
@onready var door_open_player = $"../../Map/DoorCollider/DoorOpenPlayer"
@onready var open_door = $"../../Map/OpenDoor"


func knock():
	if Global.knockDoor_in_range and Input.is_action_just_pressed("interact"):
		if door_knock_player:
			door_knock_player.play()


func _on_door_knock_player_finished():
	door_open_player.play()
	open_door.visible = true
	Global.knockDoor_open = true


func enter_door():
	if Global.knockDoor_open and Global.knockDoor_in_range:
		get_tree().change_scene_to_file("res://scenes/starter_room.tscn")

