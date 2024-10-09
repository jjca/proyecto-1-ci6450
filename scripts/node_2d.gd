extends Node2D
# Position y rotation vienen definidos como vector y flotante respectivamente
var speed : int = 400
var orientation : float
var angular : float
var velocity : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update(delta)
	
	
func update(delta: float):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	if Input.is_action_pressed("w"):
		velocity.y += 1
	if Input.is_action_pressed("s"):
		velocity.y -= 1
	if Input.is_action_pressed("d"):
		velocity.x += 1
	if Input.is_action_pressed("a"):
		velocity.x -= 1

	#rotation = angular * delta	
	#orientation += rotation
	
	if velocity.length() > 0:
		#velocity.x += orientation
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	

func newOrientation(current: float, velocity: Vector2) -> float:
	if velocity.length() > 0:
		return atan2(-velocity.x,velocity.y)
	else:
		return current
	
	#velocity += steering.linear * delta
	#rotation += steering.angular * delta
	
