extends Node
signal turn
var player: CharacterBody2D = get_parent()
var speed = 100 
@export var sprite: AnimatedSprite2D  
@export var tile_collision_detector: RayCast2D
var tiles: TileMapLayer = Backgrounds.get_child(1)
var velocity = Vector2(0, 0)
var collision_test_running: bool = false

enum States {
	LEFT,
	RIGHT, 
	UP,
	DOWN
}
var state = States.LEFT
func _ready() -> void:
	player = get_parent()


func _physics_process(delta: float) -> void:
	
	if collision_test_running: 
		test_collision()
	
	player.velocity = velocity
	player.move_and_slide()
	

func snap_tile(): 
	var tile = tiles.local_to_map(tiles.to_local(player.global_position) + Vector2(3,3)* player.velocity.normalized())
	var tile_global_pos = tiles.to_global(tiles.map_to_local(tile))
	while player.global_position != tile_global_pos: 
		player.global_position.x = move_toward(player.global_position.x, tile_global_pos.x, 0.017)
		player.global_position.y = move_toward(player.global_position.y, tile_global_pos.y, 0.017)
		
func test_collision(): 
	if not tile_collision_detector.is_colliding(): 
		turn.emit()
		collision_test_running = false
		return

func _input(event: InputEvent) -> void:
	var character_back = -8 * player.velocity.normalized().x
	var character_peak = -8 * player.velocity.normalized().y
	match event: 
		var x when x.is_action_pressed("move_left"): 
			tile_collision_detector.target_position = Vector2(-16, character_peak) 
			collision_test_running = true
			await turn
			snap_tile()
			state = States.LEFT 
			state_machine()
			if tile_collision_detector.target_position != Vector2(-16, character_peak):
		var x when x.is_action_pressed("move_right"):
			if tile_collision_detector.target_position != Vector2(16, character_peak): 
				tile_collision_detector.target_position = Vector2(16, character_peak)
				collision_test_running = true
				await turn
				snap_tile()
				state = States.RIGHT
				state_machine() 
		var x when x.is_action_pressed("move_up"):
			if tile_collision_detector.target_position != Vector2(character_back, -16):
				tile_collision_detector.target_position = Vector2(character_back, -16)
				collision_test_running = true
				await turn
				snap_tile()
				state = States.UP
				state_machine()
		var x when x.is_action_pressed("move_down"):
			if tile_collision_detector.target_position != Vector2(character_back, 16):
				tile_collision_detector.target_position = Vector2(character_back, 16)
				collision_test_running = true
				await turn
				snap_tile()
				state = States.DOWN
				state_machine()
func state_machine(): 
	match state: 
		States.LEFT: 
			sprite.flip_h = true
			sprite.play("run")
			sprite.rotation_degrees = 0
			velocity = Vector2(-1 * speed, 0)
		States.RIGHT: 
			sprite.flip_h = false
			sprite.play("run")
			sprite.rotation_degrees = 0
			velocity = Vector2(1 * speed, 0)
		States.UP:
			sprite.flip_h = false
			sprite.rotation_degrees = -90
			sprite.play("run")
			velocity = Vector2(0, -1 * speed)
		States.DOWN:
			sprite.flip_h = false
			sprite.rotation_degrees = 90
			sprite.play("run")
			velocity = Vector2(0, speed)
	
