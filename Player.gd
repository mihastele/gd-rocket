extends RigidBody3D

@export_range(750.0, 3000.0) var thrust: float = 1000.0
@export_range(60.0, 300.0) var torque_thrust: float = 100.0

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var victory_audio: AudioStreamPlayer = $VictoryAudio
@onready var engine_thrust_audio: AudioStreamPlayer3D = $EngineThrust

var is_transitioning: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		if !engine_thrust_audio.playing:
			engine_thrust_audio.play()
	else:
		engine_thrust_audio.stop()
	if Input.is_action_pressed("left"):
		apply_torque(Vector3(0.0, 0.0, torque_thrust * delta))
	if Input.is_action_pressed("right"):
		apply_torque(Vector3(0.0, 0.0, -torque_thrust * delta))
	#if Input.is_action_pressed("front"):
		#apply_torque(Vector3(-torque_value * delta, 0.0, 0.0))
	#if Input.is_action_pressed("back"):
		#apply_torque(Vector3(torque_value * delta, 0.0, 0.0))


func _on_body_entered(body: Node) -> void:
	if !is_transitioning:
		if "Goal" in body.get_groups():
			#print("Game won")
			complete_level(body.file_path)
		elif "Obstacle" in body.get_groups():
			#print("Game Lost")
			crash_sequence()

func crash_sequence() -> void:
	print("Game Lost")
	explosion_audio.play()
	is_transitioning = true
	set_process(false)
	engine_thrust_audio.stop()
	var tween = create_tween()
	tween.tween_interval(3.0)
	tween.tween_callback(get_tree().reload_current_scene)
	
	
func complete_level(next_level_path: String) -> void:
	print("Game won")
	victory_audio.play()
	is_transitioning = true
	var tween = create_tween()
	tween.tween_interval(3.0)
	tween.tween_callback(
		get_tree().change_scene_to_file.bind(next_level_path)
		)
	
	
