extends Node2D
## Match controller for the locked arcade league match.
## 3 periods x 3 minutes (9:00), most goals wins, sudden-death OT then a
## shootout on a tie. Pause, restart, result, player switching, the FPS
## readout, and the shootout live here.

const PERIOD_SECONDS := 180.0
const PERIODS := 3
const OVERTIME_SECONDS := 120.0
const SHOOTOUT_ATTEMPT_SECONDS := 8.0
const SHOOTOUT_ROUNDS := 3

const HOME_SPAWNS := [Vector2(300, 240), Vector2(400, 360), Vector2(300, 480)]
const AWAY_SPAWNS := [Vector2(980, 240), Vector2(880, 360), Vector2(980, 480)]
const HOME_SHOOTER_SPAWN := Vector2(560, 360)
const AWAY_SHOOTER_SPAWN := Vector2(720, 360)
const HOME_GOALIE_SPAWN := Vector2(64, 360)
const AWAY_GOALIE_SPAWN := Vector2(1216, 360)

var home_score := 0
var away_score := 0
var period := 1
var time_left := PERIOD_SECONDS
var overtime := false
var shootout := false
var shootout_round := 1
var shootout_home := 0
var shootout_away := 0
var shootout_shooter := "home"
var shootout_timer := 0.0
var match_over := false
var paused := false
var home_skaters: Array[ZombieSkater] = []
var away_skaters: Array[ZombieSkater] = []
var active_skater: ZombieSkater = null

@onready var puck: RigidBody2D = $Puck
@onready var score_label: Label = $HUD/ScoreLabel
@onready var clock_label: Label = $HUD/ClockLabel
@onready var fps_label: Label = $HUD/FPSLabel
@onready var result_label: Label = $HUD/ResultLabel
@onready var pause_menu: Control = $HUD/PauseMenu

func _ready() -> void:
	# Keep processing while paused so pause can be toggled off and R can restart.
	process_mode = Node.PROCESS_MODE_ALWAYS
	for node in get_tree().get_nodes_in_group("home"):
		if node is ZombieSkater:
			home_skaters.append(node)
	for node in get_tree().get_nodes_in_group("away"):
		if node is ZombieSkater:
			away_skaters.append(node)
	for skater in away_skaters:
		skater.ai_chase = true
	_set_active_skater(home_skaters[0])
	_update_hud()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_R):
		_restart_match()
		return
	if match_over:
		return
	if Input.is_action_just_pressed("pause"):
		_set_paused(not paused)
	if paused:
		return
	if shootout:
		_process_shootout(delta)
	else:
		time_left -= delta
		_check_goal()
		if time_left <= 0.0:
			_end_period()
	_keep_puck_in_rink()
	_update_hud()

func _process_shootout(delta: float) -> void:
	shootout_timer -= delta
	_check_goal()
	if shootout and not match_over and shootout_timer <= 0.0:
		_end_shootout_attempt()

func _check_goal() -> void:
	if puck == null:
		return
	# A goal only counts inside the goal mouth (y 300..420); anything else
	# is a shot off the boards.
	if puck.global_position.y < 300.0 or puck.global_position.y > 420.0:
		return
	if puck.global_position.x < 52.0:
		_on_goal("away")
	elif puck.global_position.x > 1228.0:
		_on_goal("home")

func _on_goal(team: String) -> void:
	if shootout:
		if team == "home":
			shootout_home += 1
		else:
			shootout_away += 1
		_end_shootout_attempt()
		return
	if team == "home":
		home_score += 1
	else:
		away_score += 1
	if overtime:
		_end_match()  # Sudden death: the first goal in OT wins.
	else:
		_reset_after_goal()

func _reset_after_goal() -> void:
	for i in home_skaters.size():
		home_skaters[i].global_position = HOME_SPAWNS[i]
		home_skaters[i].velocity = Vector2.ZERO
		home_skaters[i].has_puck = false
		home_skaters[i].stun_timer = 0.0
	for i in away_skaters.size():
		away_skaters[i].global_position = AWAY_SPAWNS[i]
		away_skaters[i].velocity = Vector2.ZERO
		away_skaters[i].has_puck = false
		away_skaters[i].stun_timer = 0.0
	if puck != null:
		puck.freeze = false
		puck.global_position = Vector2(640, 360)
		puck.linear_velocity = Vector2.ZERO
	_set_active_skater(home_skaters[0])
	home_skaters[0].has_puck = true

func _end_period() -> void:
	if overtime:
		if home_score != away_score:
			_end_match()
		else:
			_start_shootout()
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

func _start_shootout() -> void:
	shootout = true
	shootout_round = 1
	shootout_home = 0
	shootout_away = 0
	shootout_shooter = "home"
	_setup_shootout_attempt()

func _setup_shootout_attempt() -> void:
	shootout_timer = SHOOTOUT_ATTEMPT_SECONDS
	_clear_shootout_roles()
	for i in home_skaters.size():
		home_skaters[i].global_position = HOME_SPAWNS[i]
		home_skaters[i].velocity = Vector2.ZERO
		home_skaters[i].is_active = false
		home_skaters[i].ai_chase = false
		home_skaters[i].has_puck = false
	for i in away_skaters.size():
		away_skaters[i].global_position = AWAY_SPAWNS[i]
		away_skaters[i].velocity = Vector2.ZERO
		away_skaters[i].is_active = false
		away_skaters[i].ai_chase = false
		away_skaters[i].has_puck = false
	if puck != null:
		puck.freeze = false
		puck.linear_velocity = Vector2.ZERO
	var shooter: ZombieSkater
	var goalie_skater: ZombieSkater
	if shootout_shooter == "home":
		shooter = home_skaters[0]
		goalie_skater = away_skaters[2]
		shooter.global_position = HOME_SHOOTER_SPAWN
		goalie_skater.global_position = AWAY_GOALIE_SPAWN
		_set_active_skater(shooter)
	else:
		shooter = away_skaters[0]
		goalie_skater = home_skaters[2]
		shooter.global_position = AWAY_SHOOTER_SPAWN
		goalie_skater.global_position = HOME_GOALIE_SPAWN
		shooter.ai_shooter = true
		shooter.ai_shot_timer = 1.0
		shooter.ai_aim = randf_range(-1.0, 1.0)
	goalie_skater.goalie = true
	shooter.has_puck = true
	if puck != null:
		puck.global_position = shooter.global_position + Vector2(20, 0)

func _end_shootout_attempt() -> void:
	_clear_shootout_roles()
	if shootout_shooter == "home":
		shootout_shooter = "away"
		_setup_shootout_attempt()
		return
	shootout_shooter = "home"
	if shootout_round >= SHOOTOUT_ROUNDS and shootout_home != shootout_away:
		_end_match()
		return
	shootout_round += 1
	_setup_shootout_attempt()

func _clear_shootout_roles() -> void:
	for skater in home_skaters:
		skater.goalie = false
		skater.ai_shooter = false
		skater.ai_chase = false
	for skater in away_skaters:
		skater.goalie = false
		skater.ai_shooter = false
		skater.ai_chase = false

func _end_match() -> void:
	match_over = true
	_clear_shootout_roles()
	var winner := "HOME WINS" if home_score > away_score else "AWAY WINS"
	var detail := "Shootout %d — %d" % [shootout_home, shootout_away] if shootout else "Final whistle"
	result_label.text = "%s  %d — %d  (%s) — R to restart" % [winner, home_score, away_score, detail]
	clock_label.text = "%s  %d — %d" % [winner, home_score, away_score]

func _restart_match() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = value
	pause_menu.visible = value

func _set_active_skater(skater: ZombieSkater) -> void:
	for home in home_skaters:
		home.is_active = (home == skater)
	active_skater = skater

func switch_active_skater() -> void:
	if shootout or match_over or home_skaters.size() < 2:
		return
	var next_index := (home_skaters.find(active_skater) + 1) % home_skaters.size()
	_set_active_skater(home_skaters[next_index])

func _keep_puck_in_rink() -> void:
	if puck == null or puck.freeze:
		return
	var pos := puck.global_position
	var vel := puck.linear_velocity
	if pos.y < 16.0:
		pos.y = 16.0
		vel.y = absf(vel.y) * 0.6
	elif pos.y > 704.0:
		pos.y = 704.0
		vel.y = -absf(vel.y) * 0.6
	if pos.x < 16.0:
		pos.x = 16.0
		vel.x = absf(vel.x) * 0.6
	elif pos.x > 1264.0:
		pos.x = 1264.0
		vel.x = -absf(vel.x) * 0.6
	puck.global_position = pos
	puck.linear_velocity = vel

func _update_hud() -> void:
	score_label.text = "HOME %d — %d AWAY" % [home_score, away_score]
	if shootout:
		clock_label.text = "SO R%d  %d — %d  %ds" % [shootout_round, shootout_home, shootout_away, int(shootout_timer)]
	else:
		var minutes := int(time_left) / 60
		var seconds := int(time_left) % 60
		var label := "OT" if overtime else "P%d" % period
		clock_label.text = "%d:%02d  %s" % [minutes, seconds, label]
	fps_label.text = "%d FPS" % Engine.get_frames_per_second()
