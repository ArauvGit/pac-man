extends Node
@onready var player: CharacterBody2D = get_parent()
@onready var tiles: TileMapLayer = player.collect_tiles
@export var detector: Area2D

func _ready() -> void: 
	pass
func _physics_process(delta: float) -> void:
	gain_points()

func gain_points(): 
	var tile_pos = tiles.local_to_map(tiles.to_local(player.global_position) + Vector2(3,3)* player.velocity.normalized())
	var tile_global_pos = tiles.to_global(tiles.map_to_local(tile_pos))
	if player.global_position.distance_to(tile_global_pos) <= 12: 
		var tile_data: TileData = tiles.get_cell_tile_data(tile_pos) 
		if tile_data:
			if tile_data.get_custom_data("Points"): 
				player.update_score.emit(tile_data.get_custom_data("Points"))
				tiles.erase_cell(tile_pos)
