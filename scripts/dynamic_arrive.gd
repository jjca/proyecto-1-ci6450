extends Node2D

var velocity : Vector2
var maxSpeed : float = 400
var maxAcceleration : float = 60
var targetRadius : float = 60
var slowRadius : float = 300
var timeToTarget : float = 0.01
var target
var character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent().get_node("Node2D")
	character = get_node(".")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#velocity = character.velocity
	var char_velocity = getSteering(target,character)
	if char_velocity == Vector2.ZERO:
		character.velocity = Vector2.ZERO
	else:
		character.velocity += char_velocity * delta

	character.position += character.velocity * delta

func newOrientation(current,char_velocity) -> float:
	if char_velocity.length() > 0:
		return atan2(-target.position.x,target.position.y)
	else:
		return current

func getSteering(target,character):
	var char_velocity : Vector2
	var direction_to_target = target.position - character.position
	var distance_to_target = direction_to_target.length()
	var targetSpeed
	if distance_to_target < targetRadius:
		return Vector2.ZERO
		
	if distance_to_target > slowRadius:
		targetSpeed = maxSpeed
	else:
		targetSpeed = maxSpeed * distance_to_target / slowRadius
	
	var targetVelocity = direction_to_target
	targetVelocity = targetVelocity.normalized() * targetSpeed
	
	
	char_velocity = targetVelocity - character.velocity 
	char_velocity /= timeToTarget
	
	if char_velocity.length() > maxAcceleration:
		char_velocity = char_velocity.normalized() * maxAcceleration
		
	return char_velocity
	
