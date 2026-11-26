extends Node
signal left
signal right
signal up
signal down


func _input(event: InputEvent) -> void:
	var custom_actions = InputMap.get_actions().filter(func(action): return action.contains("game"))
	var test_for_event = func(action): return InputMap.action_has_event(action, event)
	if custom_actions.any(test_for_event): 
		input_pressed(custom_actions.filter(test_for_event)[0])

func input_pressed(input): 
	match input: 
		"game_move_left": 
			left.emit()
		"game_move_right": 
			right.emit()
		"game_move_up": 
			up.emit()
		"game_move_down": 
			down.emit()
