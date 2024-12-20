extends Node3D


var timer: float = 0.0
var frow: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var my_number: int = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("Spacebar or Enter was pressed")
		frow += 1
		print(frow)
		
	#timer += delta
	#print(timer)
