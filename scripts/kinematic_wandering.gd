extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var maxRotation : float = 0.03
var orientation : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets initial orientation applies the rotation
	orientation = randf_range(0.0,2.0*PI) 
	set_rotation(orientation)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update(delta)
	
func update(delta) -> void:
	velocity = getSteering()
	position += velocity * delta

func getSteering():
	orientation += randf_range(-1,1) * maxRotation
	var rotationVector = Vector2.from_angle(orientation) 
	velocity = maxSpeed * rotationVector.normalized()
	set_rotation(orientation)
	return velocity
