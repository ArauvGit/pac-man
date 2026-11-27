extends Node2D
@onready var player: CharacterBody2D = get_parent().player
@onready var environment_tiles: TileMapLayer = get_parent().environment_tiles
var player_map_position = Vector2i(0, 0)
var enemy_map_position = Vector2i(0, 0)
var a_star_grid = AStarGrid2D.new()
var target_path: PackedVector2Array = []


func _ready() -> void:
	setup()
	mark_boundaries()

func _physics_process(delta: float) -> void:
	update_target_position()

func update_target_position():
	enemy_map_position = environment_tiles.local_to_map(
		environment_tiles.to_local(
			get_parent().global_position
		)
	)
	player_map_position = environment_tiles.local_to_map(
		environment_tiles.to_local(player.global_position)
	)
	
	target_path = a_star_grid.get_id_path(
		enemy_map_position, 
		player_map_position)
	queue_redraw()

func _draw() -> void:
	var target_path_length = target_path.size()
	
	for i in range(target_path_length - 1):
		var point1 = environment_tiles.to_global(
			environment_tiles.map_to_local(target_path[i])
			)
		var point2 = environment_tiles.to_global(
			environment_tiles.map_to_local(target_path[i + 1])
			)
		draw_line(
			to_local(point1), 
			to_local(point2), 
			Color.RED,
			16)



func setup(): 
	a_star_grid.region = Rect2i(-319, -191, 624, 335)
	a_star_grid.cell_size = Vector2(16, 16)
	a_star_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	a_star_grid.update()
func mark_boundaries(): 
	for tile_pos in environment_tiles.get_used_cells(): 
		var tile = environment_tiles.get_cell_tile_data(tile_pos)
		if tile.get_collision_polygons_count(0):
			a_star_grid.set_point_solid(tile_pos)


	
