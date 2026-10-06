extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var room := 0

@onready var gate: ColorRect = $Gate
@onready var room_b: ColorRect = $RoomB
@onready var runner: ColorRect = $Runner

func _ready() -> void:
	$SheetLens.make_current()
	room_b.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and room == 0:
		rules.take_dash()
		rules.unpack_state({"dash_owned": true, "checkpoint": "room-a"})
		gate.color = Color(0.3, 0.6, 0.3)
	if event.is_action_pressed("leap") and rules.may_room_b():
		rules.stash_run()
		_go("res://scenes/room_b.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
