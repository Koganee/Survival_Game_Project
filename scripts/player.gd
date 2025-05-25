extends CharacterBody3D

@onready var door_interaction = $DoorInteraction
@onready var dialogue_narration = $DialogueNarration
@onready var dialogue_box = $Head/Camera3D/CanvasLayer/DialogueBox

@onready var footstep_player = $FootstepPlayer
var footstep_timer := 0.0
var footstep_interval := 0.4  # Time between footsteps

var speed
const WALK_SPEED = 3.75
const SPRINT_SPEED = 3.75
const JUMP_VELOCITY = 0
const SENSITIVITY = 0.004

#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

@onready var head = $Head
@onready var camera = $Head/Camera3D

var player_can_move = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	dialogue_narration.start_dialogue()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	if player_can_move == false:
		if Input.is_action_just_pressed("interact"):
			await dialogue_box.show_next_line()
			if dialogue_box.is_end_of_dialogue():
				player_can_move = true
				dialogue_box.visible = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if player_can_move == true:
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		# Handle Sprint.
		if Input.is_action_pressed("sprint"):
			speed = SPRINT_SPEED
		else:
			speed = WALK_SPEED

		# Get the input direction and handle the movement/deceleration.
		var input_dir = Input.get_vector("left", "right", "up", "down")
		var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if is_on_floor():
			if direction:
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
			else:
				velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
				velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
		# Head bob
		t_bob += delta * velocity.length() * float(is_on_floor())
		camera.transform.origin = _headbob(t_bob)
		
		# FOV
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
		
		move_and_slide()
		
		# Head bob and footstep sound
		t_bob += delta * velocity.length() * float(is_on_floor())
		camera.transform.origin = _headbob(t_bob)

		# Play footstep sounds
		if is_on_floor() and input_dir != Vector2.ZERO:
			footstep_timer -= delta
			if footstep_timer <= 0.0:
				if not footstep_player.playing:
					footstep_player.play()
				footstep_timer = footstep_interval
		else:
			footstep_timer = 0.0
		
		door_interaction.knock()
		door_interaction.enter_door()


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
