class_name Face extends Align
var align = Align.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(align)
	print(align.target)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	return
	target = get_parent().get_node("Node2D")
	character = get_node("Sprite2D")
	_update(target)
	pass

func _update(target):
	faceGetSteering(target,character)

func faceGetSteering(target,character):
	var direction = target.position - character.position
	if direction.length() == 0:
		return target
	var explicitTarget
	align.target = explicitTarget
	align.target.rotation = atan2(-direction.x,direction.y)
	return align.getSteering(align.target,character)
