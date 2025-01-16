extends Node

@onready var tori: Tori = $Tori
@onready var tile_map: TileMapLayer = $TileMapLayer
#var navigable_tiles: Array[Vector2i]
#var navigable_points: Array[Vector2]
@onready var astar: AStar2D = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tori.navigation_agent.connect("navigation_finished", self.hide_crosshair)
	get_node("Crosshair").visible = false
	
	var tiles : Array[Vector2i] = tile_map.get_used_cells()
	var tile_id_lookup = {}
	
	print(tiles)
	for i in range(0, tiles.size()):
		var tile_coords : Vector2i = tiles[i]
		var map_coords : Vector2 = tile_map.map_to_local(tile_coords)
		#navigable_points.append(map_coords)
		astar.add_point(i, map_coords)
		tile_id_lookup[tile_coords] = i
	
	for i in range(0, tiles.size()):
		var tile : Vector2i = tiles[i]
		var directions := [
			Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT,
			Vector2i.RIGHT + Vector2i.UP,
			Vector2i.RIGHT + Vector2i.DOWN,
			Vector2i.LEFT + Vector2i.UP,
			Vector2i.LEFT + Vector2i.DOWN
		]
		
		for dir : Vector2i in directions:
			var check := tile + dir
			var check_tile_id = tile_id_lookup.get(check)
			
			if check_tile_id != null:
				astar.connect_points(i, check_tile_id)

func move_crosshair(location):
	get_node("Crosshair").visible = true
	get_node("Crosshair").position = location
	get_node("Crosshair").reset_blink()
	
func hide_crosshair():
	get_node("Crosshair").visible = false

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		var try_location = get_viewport().get_camera_2d().get_global_mouse_position()
		
		var from := astar.get_closest_point(tori.position)
		var to := astar.get_closest_point(try_location)
		var path := astar.get_point_path(from, to)
		
		print(path)
		
		var to_position := astar.get_point_position(to)
		tori.set_target_location(to_position)
		#tori.navigation_agent.
		move_crosshair(to_position)
		print(to_position)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
