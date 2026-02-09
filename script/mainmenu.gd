extends Control

func _ready() -> void:
	pass

func _on_włącz_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_błędny_program_toggled(toggled_on: bool) -> void:
	Ustawienia.BłĘDNY_PROGRAM = true
func _on_h_slider_value_changed(value: float) -> void:
	Ustawienia.CHANCE = value
func _on_x_value_changed(value: float) -> void:
	Ustawienia.GAMESIZEX = value
func _on_y_value_changed(value: float) -> void:
	Ustawienia.GAMESIZEY = value
