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
	if Input.is_action_pressed("arribaW"):
		rotation += PI/28
	if Input.is_action_pressed("izqA"):
		rotation -= PI/28
	if Input.is_action_pressed("derD"):
		rotation += PI/28
	if Input.is_action_pressed("AbajoS"):
		rotation -= PI/28
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		rotation = PI
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		rotation = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		rotation = PI/2
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		rotation = 3*PI/2
	#rotation = angular * delta	
	
	
	if velocity.length() > 0:
		#velocity.x += orientation
		velocity = velocity.normalized() * speed
	position += velocity * delta
	#rotation = -newOrientation(rotation,velocity)
	

func newOrientation(current: float, velocity: Vector2) -> float:
	if velocity.length() > 0:
		return atan2(-velocity.x,velocity.y)
	else:
		return current
	
	#velocity += steering.linear * delta
	#rotation += steering.angular * delta
	
