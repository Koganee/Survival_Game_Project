class_name RadioInteraction
extends Node

@onready var radio_player = $"../../Level/Radio/Area3D/RadioPlayer"

func activate_radio():
	if Global.radio_in_range and Input.is_action_just_pressed("interact"):
		radio_player.play()
