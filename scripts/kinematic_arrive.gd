extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var radius : float = 80
var timeToTarget : float = 0.5
var maxRotation : float = 0.3
var target
var character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent().get_node("Node2D")
	character = get_node(".")
	character.set_rotation(atan2(-target.position.x,target.position.y))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#velocity = character.velocity
	velocity = getSteering(target,character)
	if velocity == Vector2.ZERO:
		character.velocity = Vector2.ZERO
	else:
		character.velocity += velocity
	character.position += character.velocity * delta

func newOrientation(current,char_velocity) -> float:
	if char_velocity.length() > 0:
		return atan2(-target.position.x,target.position.y)
	else:
		return current

func getSteering(target,character):
	var char_velocity = target.position - character.position
	
	if char_velocity.length() < radius:
		return Vector2.ZERO
		
	char_velocity /= timeToTarget
	
	if char_velocity.length() > maxSpeed:
		char_velocity = char_velocity.normalized() * maxSpeed

	return char_velocity
	
