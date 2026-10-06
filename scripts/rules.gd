extends RefCounted

var dash_owned := false
var climb_owned := false
var checkpoint := ""

func cross_gate() -> bool:
	return dash_owned

func take_dash() -> void:
	dash_owned = true

func take_climb() -> void:
	climb_owned = true

func cross_ledge() -> bool:
	return climb_owned

func pack_state() -> Dictionary:
	return {"dash_owned": dash_owned, "climb_owned": climb_owned, "checkpoint": checkpoint}

func unpack_state(data: Dictionary) -> void:
	dash_owned = bool(data.get("dash_owned", false))
	climb_owned = bool(data.get("climb_owned", false))
	checkpoint = str(data.get("checkpoint", ""))

func reset_run() -> void:
	dash_owned = false
	climb_owned = false
	checkpoint = ""

static var saved_run: Dictionary = {}

func stash_run() -> Dictionary:
	saved_run = pack_state()
	return saved_run

func may_room_b() -> bool:
	return dash_owned
