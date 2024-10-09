extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var maxAcceleration : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	var char_velocity : Vector2 = target.position - character.position
	char_velocity += char_velocity.normalized() * maxAcceleration
	return char_velocity
