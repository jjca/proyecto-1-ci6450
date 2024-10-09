extends Node2D

var maxAngularAcceleration : float  = 0.1
var maxRotation : float = 10
var targetRadius : float = 0.2
var slowRadius : float = 0.1
var timeToTarget : float = 0.1
var target
var character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(mapToRange(PI))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	target = get_node("Objetivo")
	character = get_node("Sprite2D")
	#print(position)
	#print(character.position)
	if Input.is_action_pressed("ui_up"):
		target.rotation = PI/2
	if Input.is_action_pressed("ui_left"):
		target.rotation = PI
	if Input.is_action_pressed("ui_right"):
		target.rotation = 0
	if Input.is_action_pressed("ui_down"):
		target.rotation = 3*PI/2 
	var rot = getSteering(target,character)
	if rot == null:
		return
	else:
		character.rotation = rot

func mapToRange(angle: float):
	return fmod((angle + PI),(2 * PI)) - PI
	
func getSteering(target_func,character_func):
	var char_rotation = target.rotation
	char_rotation = target_func.rotation - character_func.rotation
	var targetRotation
	char_rotation = mapToRange(char_rotation)
	var rotationSize = abs(char_rotation)
	if rotationSize < targetRadius:
		return null
	#print("elrotationsize",rotationSize)
	if rotationSize > slowRadius:
		targetRotation = maxRotation
	else:
		targetRotation = maxRotation * rotationSize / slowRadius
	
	targetRotation *= char_rotation / rotationSize
	
	var res_rotation = targetRotation - target_func.rotation
	res_rotation /= timeToTarget
	
	var angularAcceleration = abs(res_rotation)
	#print("angularrr",angularAcceleration)
	if angularAcceleration > maxAngularAcceleration:
		res_rotation /= angularAcceleration
		res_rotation *= maxAngularAcceleration
	#print("No pasa anda",res_rotation)
	return res_rotation
