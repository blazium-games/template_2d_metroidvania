extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _ready() -> void:
	$SheetLens.make_current()
	if not Rules.saved_run.is_empty():
		rules.unpack_state(Rules.saved_run)
	rules.take_climb()
