extends Node2D

var maxAngularAcceleration : float  = 300
var maxRotation : float = 50
var targetRadius : float = 0.2
var slowRadius : float = 0.01
var timeToTarget : float = 0.1
var target
var character
var explicitTarget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target = get_parent().get_parent().get_node("Node2D")
	character = get_node(".")
	update(delta,character,target)
	
func update(delta,character,target) -> void:
	var rot = getFaceSteering(target,character)
	if rot == null:
		rot = 0
	character.rotation += rot * delta
	
func mapToRange(angle: float):
	return fmod((angle + PI),(2 * PI)) - PI
	
func getFaceSteering(target,character):
	var direction = target.position - character.position
	if direction.length() == 0:
		return null
	
	var align_target : Node2D = target
	character.set_rotation(atan2(-direction.x,direction.y))
	return getAlignSteering(align_target,character)

	
func getAlignSteering(target,character):
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
