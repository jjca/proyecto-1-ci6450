extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var radius : float = 80
var timeToTarget : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_parent().get_node("Node2D")
	var character = get_node(".")
	velocity = character.velocity
	velocity = getSteering(target,character)
	if velocity == Vector2.ZERO:
		character.velocity = Vector2.ZERO
	else:
		character.velocity += velocity
	character.position += character.velocity * delta


func getSteering(target,character):
	var velocity = target.position - character.position
	
	if velocity.length() < radius:
		return Vector2.ZERO
		
	velocity /= timeToTarget
	
	if velocity.length() > maxSpeed:
		velocity = velocity.normalized() * maxSpeed
	
	return velocity
	
