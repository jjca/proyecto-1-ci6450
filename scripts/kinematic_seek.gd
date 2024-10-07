extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_parent().get_node("Node2D")
	var character = get_node(".")
	velocity = character.velocity
	character.velocity += getSteering(target,character)
	character.position += character.velocity * delta


func getSteering(target,character):
	var velocity = target.position - character.position
	velocity = velocity.normalized() * maxSpeed
	return velocity
	
