extends RigidBody3D


var magnitude: float = 1000.0
var torque_value: float = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * magnitude)
	if Input.is_action_pressed("left"):
		apply_torque(Vector3(0.0, 0.0, torque_value * delta))
	if Input.is_action_pressed("right"):
		apply_torque(Vector3(0.0, 0.0, -torque_value * delta))
	#if Input.is_action_pressed("front"):
		#apply_torque(Vector3(-torque_value * delta, 0.0, 0.0))
	#if Input.is_action_pressed("back"):
		#apply_torque(Vector3(torque_value * delta, 0.0, 0.0))


func _on_body_entered(body: Node) -> void:
	if body.name == "LandingPad":
		print("Game won")
	elif body.name == "Floor":
		print("Game Lost")
