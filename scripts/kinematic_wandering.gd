extends Node2D

var maxSpeed : float = 50
var velocity : Vector2 = Vector2.ZERO
var maxRotation : float = 0.001
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var character = get_node(".")
	rotation = randf_range(-1.0,1.0) * maxRotation * PI
	velocity = getSteering(character,rotation)
	
	character.velocity += velocity * rotation
	character.position += character.velocity * delta
	

func getSteering(character,rotation):
	var rotationVector : Vector2 = Vector2.from_angle(rotation)
	print(rotationVector)
	var velocity = maxSpeed * rotationVector
	
	return velocity
	
