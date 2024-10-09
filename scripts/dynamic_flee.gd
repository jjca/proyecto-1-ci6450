extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var maxAcceleration : float = 30
var minRadius : float = 65
var maxRadius : float = 400
var timeToTarget : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node(".").position = get_parent().get_node("Node2D").position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_parent().get_node("Node2D")
	var character = get_node(".")
	update(delta,character,target)

func update(delta,character,target) -> void:
	character.velocity = getSteering(target,character)
	character.position += character.velocity * delta

func getSteering(target,character):
	var char_velocity : Vector2 = character.position - target.position
	char_velocity += char_velocity.normalized() * maxAcceleration
	if char_velocity.length() > maxRadius:
		return Vector2.ZERO
	return char_velocity
