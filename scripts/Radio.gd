extends StaticBody3D

func _on_area_3d_body_entered(body):
	Global.radio_in_range = true

func _on_area_3d_body_exited(body):
	Global.radio_in_range = false


func _on_portal_entrance_body_entered(body):
	if body is CharacterBody3D:
		get_tree().change_scene_to_file("res://scenes/portal_scene.tscn")
