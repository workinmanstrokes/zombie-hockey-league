extends Node2D
## Match controller for the locked arcade league match.
## 3 periods x 3 minutes (9:00), most goals wins, OT then shootout on a tie.
## Pause, restart, result, and player switching live here.

const PERIOD_SECONDS := 180.0
const PERIODS := 3
const OVERTIME_SECONDS := 120.0

var home_score := 0
var away_score := 0
var period := 1
var time_left := PERIOD_SECONDS
var overtime := false
var match_over := false
var paused := false
var active_skater: ZombieSkater = null

@onready var puck: RigidBody2D = $Puck
@onready var score_label: Label = $HUD/ScoreLabel
@onready var clock_label: Label = $HUD/ClockLabel
@onready var pause_menu: Control = $HUD/PauseMenu

func _ready() -> void:
	$Player.add_to_group("home")
	$Opponent.add_to_group("away")
	active_skater = $Player
	active_skater.is_active = true
	_update_hud()

func _process(delta: float) -> void:
	if match_over:
		return
	if Input.is_action_just_pressed("pause"):
		_set_paused(not paused)
	if paused:
		return
	if Input.is_key_pressed(KEY_R):
		_restart_match()
	time_left -= delta
	_check_goal()
	if time_left <= 0.0:
		_end_period()
	_update_hud()

func _check_goal() -> void:
	if puck == null:
		return
	if puck.global_position.x < 52.0:
		away_score += 1
		_reset_after_goal()
	elif puck.global_position.x > 1228.0:
		home_score += 1
		_reset_after_goal()

func _reset_after_goal() -> void:
	puck.global_position = Vector2(640, 360)
	puck.linear_velocity = Vector2.ZERO
	$Player.global_position = Vector2(400, 360)
	$Opponent.global_position = Vector2(880, 360)
	$Player.has_puck = true

func _end_period() -> void:
	if overtime:
		_end_match()
		return
	if period < PERIODS:
		period += 1
		time_left = PERIOD_SECONDS
		_reset_after_goal()
	elif home_score != away_score:
		_end_match()
	else:
		overtime = true
		time_left = OVERTIME_SECONDS
		_reset_after_goal()

func _end_match() -> void:
	match_over = true
	var winner := "HOME WINS" if home_score > away_score else "AWAY WINS"
	clock_label.text = "%s  %d — %d  (R to restart)" % [winner, home_score, away_score]

func _restart_match() -> void:
	get_tree().reload_current_scene()

func _set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = value
	pause_menu.visible = value

func switch_active_skater() -> void:
	var skaters := get_tree().get_nodes_in_group("home")
	var zombie_skaters: Array[ZombieSkater] = []
	for skater in skaters:
		if skater is ZombieSkater:
			zombie_skaters.append(skater)
	if zombie_skaters.size() < 2:
		return  # Nothing to switch to yet — add teammates to enable switching.
	var next_index := (zombie_skaters.find(active_skater) + 1) % zombie_skaters.size()
	for skater in zombie_skaters:
		skater.is_active = (skater == zombie_skaters[next_index])
	active_skater = zombie_skaters[next_index]

func _update_hud() -> void:
	score_label.text = "HOME %d — %d AWAY" % [home_score, away_score]
	var minutes := int(time_left) / 60
	var seconds := int(time_left) % 60
	var label := "OT" if overtime else "P%d" % period
	clock_label.text = "%d:%02d  %s" % [minutes, seconds, label]
