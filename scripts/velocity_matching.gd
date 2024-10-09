extends Node2D

var maxAcceleration : float = 500
var timeToTarget : float = 0.3
# Called when the node enters the scene tree for the first time
var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_node(".").position = get_parent().get_node("Node2D").position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_parent().get_node("Node2D")
	var character = get_node(".")
	update(delta,character,target)

func update(delta,character,target) -> void:
	var charvel = getSteering(target,character)
	character.position += charvel * delta

func getSteering(target,character):
	var char_velocity = target.velocity - character.velocity
	char_velocity /= timeToTarget
	
	if char_velocity.length() > maxAcceleration:
		char_velocity = char_velocity.normalized()
		char_velocity *= maxAcceleration
		
	#print(char_velocity.length())
	return char_velocity
