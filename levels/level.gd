extends Node

var tori

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tori = get_node("Tori")
	tori.connect("new_target_location", self.move_crosshair)
	tori.connect("reached_target_location", self.hide_crosshair)
	get_node("Crosshair").visible = false

func move_crosshair(location):
	get_node("Crosshair").visible = true
	get_node("Crosshair").position = location
	get_node("Crosshair").reset_blink()
	
func hide_crosshair():
	get_node("Crosshair").visible = false

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		var target_location = get_viewport().get_camera_2d().get_global_mouse_position()
		var tile_map : TileMapLayer = get_node("TileMapLayer")
		#target_location.x = target_location.x % float(tile_map.tile_set.tile_size.x)
		tori.set_target_location(target_location)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
