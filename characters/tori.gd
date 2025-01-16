class_name Tori

extends Node2D

var target_location: Vector2
const SPEED := 100

signal reached_target_location
var path: PackedVector2Array

func set_target_location(location):
	var diff = target_location - position

func _process(delta: float) -> void:
	if path.size() == 0:
		reached_target_location.emit()
	elif path.size() > 0:
		# in case we are going to IMMEDIATELY turn around after going to path[0]
		# we should just go to path[1] instead. This results in less jittery
		# movement
		if path.size() >= 2:
			var toPath0 = path[0] - position
			var toPath1 = path[1] - position
			if toPath0.dot(toPath1) < 0:
				path = path.slice(1)
		var target_location := path[0]
		var diff := target_location - position
		$Sprite2D.flip_h = diff.x < 0
		
		const MAGIC_CLOSE_DISTANCE := 2
		if diff.length() > MAGIC_CLOSE_DISTANCE:
			var velocity := (diff / diff.length()) * SPEED
			position += velocity * delta
		else:
			path = path.slice(1)
