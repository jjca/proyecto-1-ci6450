extends Node2D

var maxSpeed : float = 100
var velocity : Vector2 = Vector2.ZERO
var maxAcceleration : float = 10
var maxPrediction: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_parent().get_node("Node2D")
	var character = get_node(".")
	update(delta,character,target)

func update(delta,character,target) -> void:
	character.velocity = getSteering(target,character) * delta
	#character.position += character.velocity * delta

func getSteering(target,character):
	var char_direction : Vector2 = target.position - character.position
	var distance = char_direction.length()
	
	var speed = character.velocity.length()
	var prediction
	if speed <= distance / maxPrediction:
		prediction = maxPrediction
	else:
		prediction = distance / speed
	
	character.position += target.velocity * prediction
	
	return char_direction

	
