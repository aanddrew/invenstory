extends Sprite2D

const BLINK_SPEED = 1
var blink_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func reset_blink():
	blink_progress = 1.7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	blink_progress += delta / BLINK_SPEED
	if blink_progress >= 1.7:
		blink_progress = 0.3
	self.modulate = Color.WHITE * ((abs(blink_progress - 1)) * 0.7 + 0.3)
	
	pass
