extends CharacterBody2D
class_name ZombieSkater
## One zombie skater in the locked arcade league match.
## Skate, pass, shoot, check, and switch — nothing else lives in this script.
## Zombie rules: a checked skater is flattened for 2 seconds and drops the puck.
## The puck is carried (frozen to the carrier) and picked up on contact.
## Controls: left-stick dead zone 0.2 (see docs/CONTROLS_AND_MIN_SPEC.md), so
## stick drift never skates the active skater. A flattened zombie lies flat
## (rotated 90 degrees) and a check pops a limb-debris marker loose — the
## limb-popping hit feedback, with no art asset needed.

const SKATE_SPEED := 320.0
const SKATE_ACCEL := 1800.0
const CHECK_IMPULSE := 520.0
const CHECK_COOLDOWN := 0.8
const STUN_SECONDS := 2.0
const PICKUP_RADIUS := 30.0
const GOALIE_TRACK_SPEED := 110.0
const GOALIE_REACT_DISTANCE := 220.0
const STICK_DEADZONE := 0.2
const LIMB_DEBRIS_SECONDS := 0.6

var has_puck := false
var is_active := false
var ai_chase := false
var ai_shooter := false
var goalie := false
var check_timer := 0.0
var stun_timer := 0.0
var ai_shot_timer := 0.0
var ai_aim := 0.0

@onready var puck: RigidBody2D = get_parent().get_node_or_null("Puck")

func _physics_process(delta: float) -> void:
	if stun_timer > 0.0:
		stun_timer -= delta
		rotation = PI / 2.0
		velocity = velocity.move_toward(Vector2.ZERO, SKATE_ACCEL * delta)
		move_and_slide()
		return

	rotation = 0.0
	check_timer = max(0.0, check_timer - delta)

	if goalie:
		_goalie_move(delta)
	elif ai_chase:
		_chase_puck(delta)
	elif is_active:
		_player_move(delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SKATE_ACCEL * delta)
		move_and_slide()

	if has_puck:
		_carry_puck()
	elif puck != null and not _puck_held():
		if global_position.distance_to(puck.global_position) < PICKUP_RADIUS:
			has_puck = true
			puck.linear_velocity = Vector2.ZERO

	if ai_shooter and has_puck:
		ai_shot_timer -= delta
		if ai_shot_timer <= 0.0:
			shoot_puck()

func _player_move(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down", STICK_DEADZONE)
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

func _chase_puck(delta: float) -> void:
	if puck == null:
		return
	var direction := puck.global_position - global_position
	if direction.length() < 24.0:
		velocity = velocity.move_toward(Vector2.ZERO, SKATE_ACCEL * delta)
	else:
		velocity = velocity.move_toward(direction.normalized() * SKATE_SPEED * 0.85, SKATE_ACCEL * delta)
	move_and_slide()

func _goalie_move(delta: float) -> void:
	# Guard the goal mouth: track the puck's height once it is close.
	# The goalie is too slow to cover a corner shot, so aiming wide scores.
	var target_y := 360.0
	if puck != null and absf(puck.global_position.x - global_position.x) < GOALIE_REACT_DISTANCE:
		target_y = puck.global_position.y
	var dy := clampf(target_y - global_position.y, -1.0, 1.0)
	velocity = Vector2(0.0, dy * GOALIE_TRACK_SPEED)
	move_and_slide()

func _carry_puck() -> void:
	if puck == null:
		return
	puck.freeze = true
	var offset := Vector2(20.0, 0.0)
	if velocity.length() > 10.0:
		offset = velocity.normalized() * 24.0
	puck.global_position = global_position + offset
	puck.linear_velocity = Vector2.ZERO

func _puck_held() -> bool:
	for group_name in ["home", "away"]:
		for node in get_tree().get_nodes_in_group(group_name):
			if node is ZombieSkater and node != self and node.has_puck:
				return true
	return false

func pass_puck() -> void:
	if not has_puck or puck == null:
		return
	has_puck = false
	var teammate := _nearest_teammate()
	if teammate == null:
		return
	# The puck travels; the teammate (or anyone) picks it up on contact.
	puck.freeze = false
	var direction := (teammate.global_position - global_position).normalized()
	puck.linear_velocity = direction * 480.0

func shoot_puck() -> void:
	if not has_puck or puck == null:
		return
	has_puck = false
	# Aim with up/down: hold up or down while shooting to pick a corner.
	# The goalie guards the middle, so corner shots score and central ones don't.
	var goal_x := 1240.0 if global_position.x < 640.0 else 40.0
	var aim_y := ai_aim if ai_shooter else Input.get_vector("move_left", "move_right", "move_up", "move_down", STICK_DEADZONE).y
	var target := Vector2(goal_x, 360.0 + aim_y * 50.0)
	var direction := (target - global_position).normalized()
	puck.freeze = false
	puck.linear_velocity = direction * 700.0

func check_opponent() -> void:
	if check_timer > 0.0:
		return
	check_timer = CHECK_COOLDOWN
	var opponents := get_tree().get_nodes_in_group("away" if is_in_group("home") else "home")
	for opponent in opponents:
		if opponent is CharacterBody2D and global_position.distance_to(opponent.global_position) < 64.0:
			var push := (opponent.global_position - global_position).normalized()
			opponent.velocity += push * CHECK_IMPULSE
			if opponent is ZombieSkater:
				opponent.stun_timer = STUN_SECONDS
				_spawn_limb_debris(opponent.global_position, Color(0.2, 0.6, 0.25) if opponent.is_in_group("home") else Color(0.6, 0.2, 0.25))
				if opponent.has_puck:
					opponent.has_puck = false
					has_puck = true

func _spawn_limb_debris(at: Vector2, color: Color) -> void:
	# Limb-popping hit feedback: a small piece of the flattened zombie pops
	# loose on a check and vanishes after LIMB_DEBRIS_SECONDS. No art asset
	# is needed for the gag to read on screen.
	var limb := ColorRect.new()
	limb.size = Vector2(14.0, 6.0)
	limb.color = color
	limb.position = at - Vector2(7.0, 3.0)
	get_parent().add_child(limb)
	get_tree().create_timer(LIMB_DEBRIS_SECONDS).timeout.connect(limb.queue_free)

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
