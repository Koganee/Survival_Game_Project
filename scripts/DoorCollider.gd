extends Area3D

@onready var interact_label = $"../../CharacterBody3D/Head/Camera3D/CanvasLayer/InteractLabel"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "CharacterBody3D":
		interact_label.visible = true


func _on_body_exited(body):
	if body.name == "CharacterBody3D":
		interact_label.visible = false
