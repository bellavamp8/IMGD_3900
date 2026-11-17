extends Node2D


@onready var music: AudioStreamPlayer = $AudioStreamPlayer

func is_scrolling() -> void:
	music.set_stream_paused(true)
