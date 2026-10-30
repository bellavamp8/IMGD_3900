extends Node2D

# Spawn points (screen coordinates). Add or move these as you like.
const SPAWN_POINTS: Array[Vector2] = [
	Vector2(100, 0),
	Vector2(200, 0),
	Vector2(300, 0),
]

# Distance an obstacle must be from an existing one to be accepted.
const MIN_SPACING: float = 60.0
# Scene to spawn.
const OBSTACLE_SCENE: String = "res://IMGD_3900/scenes/obstacle.tscn"
# How many times to retry finding a free spot before giving up this spawn.
const PLACEMENT_ATTEMPTS: int = 20

@export var spawn_interval: float = 1.5
@export var max_obstacles: int = 20
@export var auto_spawn: bool = true

var _timer: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Seed so runs differ from each other.
	randomize()
	if auto_spawn:
		spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not auto_spawn:
		return

	_timer += delta
	if _timer < spawn_interval:
		return

	_timer = 0.0
	spawn_obstacle()


# Instantiates one obstacle at a random free spawn point.
func spawn_obstacle() -> void:
	if get_tree().get_nodes_in_group("obstacles").size() >= max_obstacles:
		return

	var pos: Variant = _find_free_position()

	# _find_free_position returns a sentinel when nothing is free.
	if pos == null:
		return

	var scene: PackedScene = load(OBSTACLE_SCENE)
	if scene == null:
		push_error("Could not load obstacle scene: %s" % OBSTACLE_SCENE)
		return

	var obs: Node2D = scene.instantiate()
	obs.position = pos
	add_child(obs)
	obs.add_to_group("obstacles")


# Returns a random spawn point that is far enough from existing obstacles.
# Falls back to any random point if none is clear. Returns null if the
# scene is empty or every point is taken.
func _find_free_position() -> Variant:
	if SPAWN_POINTS.is_empty():
		push_error("SPAWN_POINTS is empty; nothing to spawn.")
		return null

	var points: Array[Vector2] = SPAWN_POINTS.duplicate()
	points.shuffle()

	for i in range(min(PLACEMENT_ATTEMPTS, points.size())):
		var candidate: Vector2 = points[i]
		if _is_clear(candidate):
			return candidate

	# Nothing was clear — fall back to a random point so spawning continues.
	return SPAWN_POINTS[randi() % SPAWN_POINTS.size()]


# True if no existing obstacle is closer than MIN_SPACING to pos.
func _is_clear(pos: Vector2) -> bool:
	for obs in get_tree().get_nodes_in_group("obstacles"):
		if obs.position.distance_to(pos) < MIN_SPACING:
			return false
	return true


# Clears all spawned obstacles (handy for restarts).
func clear_obstacles() -> void:
	for obs in get_tree().get_nodes_in_group("obstacles"):
		obs.queue_free()
	_timer = 0.0
