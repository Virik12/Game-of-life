extends Control

const GAMESIZEX = 64
const GAMESIZEY = 48
const CHANCE = 20
const GAMESPEED = 1
var BłĘDNY_PROGRAM = false

func _ready() -> void:
	pass

func _on_włącz_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_błędny_program_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
