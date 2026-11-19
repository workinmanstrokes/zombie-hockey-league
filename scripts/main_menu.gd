extends Control
## Main menu: one button starts the locked arcade match.
## The other two show the controls and the build sheet in-game so the
## menu never dead-ends.

@onready var hint: Label = $Hint

func _ready() -> void:
	$PlayButton.pressed.connect(_on_play_pressed)
	$ControlsButton.pressed.connect(_on_controls_pressed)
	$BuildSheetButton.pressed.connect(_on_build_sheet_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rink.tscn")

func _on_controls_pressed() -> void:
	hint.text = "WASD / arrows skate — Space pass, J shoot, K check, Tab switch skater, Esc pause. Controller: left stick, X pass, A shoot, B check, Y switch."

func _on_build_sheet_pressed() -> void:
	hint.text = "One mode: arcade league match, 3 periods x 3 minutes. Most goals wins; tie goes to 2-min OT, then a shootout. NOT a manager sim, NOT tower defence, NOT a story RPG."
