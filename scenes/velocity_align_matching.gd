extends Node2D

var maxAngularAcceleration : float  = 3
var maxRotation : float = 5
var targetRadius : float = 0.02
var slowRadius : float = 0.01
var timeToTarget : float = 0.1
var maxAcceleration : float = 400
# Called when the node enters the scene tree for the first time
var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	print(mapToRange(PI))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var target = get_parent().get_parent().get_node("Node2D")
	var character = get_node(".")
	update(delta,character,target)
	
func update(delta,character,target) -> void:
	var rot = getSteering(target,character)
	if rot == null:
		rot = 0
	character.rotation += rot * delta
	#print("aafs",character.velocity)
	var charvel = getSteeringVelocity(target,character)
	character.velocity = charvel
	character.position += charvel * delta
	
	
func mapToRange(angle: float):
	return fmod((angle + PI),(2 * PI)) - PI

func getSteeringVelocity(target,character):
	var char_velocity = target.velocity - character.velocity
	char_velocity /= timeToTarget
	
	if char_velocity.length() > maxAcceleration:
		char_velocity = char_velocity.normalized()
		char_velocity *= maxAcceleration
		
	return char_velocity

func getSteering(target,character):
	var char_rotation
	char_rotation = target.get_rotation() - character.get_rotation()
	var targetRotation
	char_rotation = mapToRange(char_rotation)
	var rotationSize = abs(char_rotation)
	
	if rotationSize < targetRadius:
		return null
	if rotationSize > slowRadius:
		targetRotation = maxRotation
	else:
		targetRotation = (maxRotation * rotationSize) / slowRadius
	
	targetRotation *= char_rotation / rotationSize
	
	var res_rotation = targetRotation - character.get_rotation()
	res_rotation /= timeToTarget
	
	var angularAcceleration = abs(res_rotation)

	if angularAcceleration > maxAngularAcceleration:
		res_rotation /= angularAcceleration
		res_rotation *= maxAngularAcceleration
	return res_rotation
