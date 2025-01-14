extends CharacterBody2D

var target_location: Vector2
const SPEED = 200

signal reached_target_location
signal new_target_location(location)

const cardinal_directions = [
	Vector2(0, 1),
	Vector2(0, -1),
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(sqrt(2), sqrt(2)),
	Vector2(-1 * sqrt(2), sqrt(2)),
	Vector2(sqrt(2), -1 * sqrt(2)),
	Vector2(-1 * sqrt(2), -1 * sqrt(2)),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	pass


func set_target_location(location):
	target_location = location
	new_target_location.emit(target_location)
	
	var diff = target_location - position
	$Sprite2D.flip_h = diff.x < 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var diff = target_location - position
	if diff.length() > 2:
		var new_direction = cardinal_directions[0]
		for direction in cardinal_directions:
			if diff.dot(direction) > diff.dot(new_direction):
				new_direction = direction
				
		velocity = new_direction * SPEED
		move_and_slide()

	else:
		reached_target_location.emit()
		velocity = Vector2.ZERO

		
