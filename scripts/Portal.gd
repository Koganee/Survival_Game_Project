extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = Time.get_ticks_msec() / 1000.0
	$MeshInstance3D.material_override.set_shader_parameter("time", t)
