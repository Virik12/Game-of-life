extends Control


func _on_włącz_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_błędny_program_toggled(toggled_on: bool) -> void:
	
	
