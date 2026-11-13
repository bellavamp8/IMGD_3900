extends Control


func _restart() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _exit() -> void:
	get_tree().quit()
