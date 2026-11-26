extends RichTextLabel
@export var collect: AudioStreamPlayer
var score: int = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_player_update_score(score_adder: int) -> void:
	score += score_adder
	match score_adder:
		10:
			collect.pitch_scale = randf_range(0.97, 1.03)
		50: 
			collect.pitch_scale = 1.3
	collect.play()
	text = str(score)
