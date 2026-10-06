extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.cross_gate(), "closed")
	rules.take_dash()
	assert_true(rules.cross_gate(), "open")

func test_save_roundtrip() -> void:
	var rules = Rules.new()
	rules.take_dash()
	rules.unpack_state({"dash_owned": true, "checkpoint": "room-b"})
	var packed := rules.pack_state()
	rules.reset_run()
	rules.unpack_state(packed)
	assert_true(rules.dash_owned, "dash restored")
	assert_eq(rules.checkpoint, "room-b", "checkpoint restored")

func test_room_b_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_room_b(), "no dash")
	rules.take_dash()
	assert_true(rules.may_room_b(), "dash owned")
	var packed := rules.stash_run()
	assert_true(bool(packed["dash_owned"]), "stashed")
	assert_true(load("res://scenes/room_b.tscn") != null, "room b loads")

func test_climb() -> void:
	var rules = Rules.new()
	assert_false(rules.cross_ledge(), "no climb")
	rules.take_climb()
	assert_true(rules.cross_ledge(), "climb owned")
	assert_false(rules.cross_gate(), "dash gate stays")
