extends CharacterBody2D
class_name ZombieSkater
## One zombie skater in the locked arcade league match.
## Skate, pass, shoot, check, and switch — nothing else lives in this script.

const SKATE_SPEED := 320.0
const SKATE_ACCEL := 1800.0
const CHECK_IMPULSE := 520.0
const CHECK_COOLDOWN := 0.8

var has_puck := false
var is_active := true
var check_timer := 0.0

@onready var puck: RigidBody2D = get_parent().get_node_or_null("Puck")

func _physics_process(delta: float) -> void:
	if not is_active:
		velocity = velocity.move_toward(Vector2.ZERO, SKATE_ACCEL * delta)
		move_and_slide()
		return

	check_timer = max(0.0, check_timer - delta)

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target := input_dir * SKATE_SPEED
	velocity = velocity.move_toward(target, SKATE_ACCEL * delta)
	move_and_slide()

	if Input.is_action_just_pressed("pass"):
		pass_puck()
	if Input.is_action_just_pressed("shoot"):
		shoot_puck()
	if Input.is_action_just_pressed("check"):
		check_opponent()
	if Input.is_action_just_pressed("switch_player"):
		request_switch()

func pass_puck() -> void:
	if not has_puck or puck == null:
		return
	has_puck = false
	var teammate := _nearest_teammate()
	if teammate == null:
		return
	var direction := (teammate.global_position - global_position).normalized()
	puck.linear_velocity = direction * 480.0
	teammate.has_puck = true

func shoot_puck() -> void:
	if not has_puck or puck == null:
		return
	has_puck = false
	# Shoot toward the opponent's goal: right for the home team, left for away.
	var goal_x := 1240.0 if global_position.x < 640.0 else 40.0
	var direction := Vector2(goal_x - global_position.x, 0).normalized()
	puck.linear_velocity = direction * 700.0

func check_opponent() -> void:
	if check_timer > 0.0:
		return
	check_timer = CHECK_COOLDOWN
	var opponents := get_tree().get_nodes_in_group("opponents" if is_in_group("home") else "home")
	for opponent in opponents:
		if opponent is CharacterBody2D and global_position.distance_to(opponent.global_position) < 64.0:
			var push := (opponent.global_position - global_position).normalized()
			opponent.velocity += push * CHECK_IMPULSE
			if opponent is ZombieSkater and opponent.has_puck:
				opponent.has_puck = false
				has_puck = true

func request_switch() -> void:
	var match_node := get_parent()
	if match_node.has_method("switch_active_skater"):
		match_node.switch_active_skater()

func _nearest_teammate() -> ZombieSkater:
	var best: ZombieSkater = null
	var best_dist := INF
	for node in get_tree().get_nodes_in_group("home" if is_in_group("home") else "away"):
		if node == self or not (node is ZombieSkater):
			continue
		var dist := global_position.distance_to(node.global_position)
		if dist < best_dist:
			best_dist = dist
			best = node
	return best
