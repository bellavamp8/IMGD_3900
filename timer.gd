extends Panel

var time: float = 60.0
var stopped = false
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	msec = fmod(time, 1) * 1000
	seconds = fmod(time, 60)
	minutes = time / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d." % seconds
	$Msecs.text = "%03d" % msec
	if time <= 0.0:
		reset_timer()

func reset_timer() -> void:
	time = 60.0

func format_timer() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
