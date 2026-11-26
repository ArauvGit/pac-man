extends CharacterBody2D
signal update_score(score_adder: int)
@export var environment_tiles: TileMapLayer 
@export var collect_tiles: TileMapLayer
#var speed = 100 
#@export var sprite: AnimatedSprite2D
#
#enum States {
	#LEFT,
	#RIGHT, 
	#UP,
	#DOWN
#}
#var state = States.LEFT
#
#
#func _physics_process(delta: float) -> void:
	#move_and_slide()
	#
#func _input(event: InputEvent) -> void:
	#match event: 
		#var x when x.is_action_pressed("move_left"): 
			#state = States.LEFT 
			#state_machine()
		#var x when x.is_action_pressed("move_right"):
			#state = States.RIGHT
			#state_machine()
		#var x when x.is_action_pressed("move_up"):
			#state = States.UP
			#state_machine()
		#var x when x.is_action_pressed("move_down"):
			#state = States.DOWN
			#state_machine()
#func state_machine(): 
	#match state: 
		#States.LEFT: 
			#sprite.flip_h = true
			#sprite.play("run")
			#sprite.rotation_degrees = 0
			#velocity = Vector2(-1 * speed, 0)
		#States.RIGHT: 
			#sprite.flip_h = false
			#sprite.play("run")
			#sprite.rotation_degrees = 0
			#velocity = Vector2(1 * speed, 0)
		#States.UP:
			#sprite.flip_h = false
			#sprite.rotation_degrees = -90
			#sprite.play("run")
			#velocity = Vector2(0, -1 * speed)
		#States.DOWN:
			#sprite.flip_h = false
			#sprite.rotation_degrees = 90
			#sprite.play("run")
			#velocity = Vector2(0, speed)
	#
