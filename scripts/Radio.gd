extends StaticBody3D

func _on_area_3d_body_entered(body):
	Global.radio_in_range = true

func _on_area_3d_body_exited(body):
	Global.radio_in_range = false
