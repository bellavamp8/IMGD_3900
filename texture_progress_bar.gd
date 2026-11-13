extends TextureProgressBar
var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = progress

func _on_distance_progress(percent: Variant) -> void:
	progress = $percent_distance # Replace with function body.
