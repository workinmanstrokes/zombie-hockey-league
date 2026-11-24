# Zombie Hockey League — Target-Device Test Log (PC)

## A correction on the VEX review's wording

VEX's items 3–4 say the zombie rules and the team-select scene were "not
tested in the phone project" / "not run in the phone build". There is no phone
build of this game. The target device is PC (Windows via Steam, Godot 4); the
only build is the Windows Desktop export (`export_presets.cfg`). So "tested on
the target device" means: run on real PC hardware. This log records what that
means and what is still unrun — it does not claim anything has been tested
that has not.

## Zombie rules — in this build, pinned to the code

The rules are implemented in this repo's scripts, not only in a design copy:

- **No offsides, no icing, no stamina** — `scripts/match.gd` and
  `scripts/player.gd` contain no offsides, icing, or stamina logic at all:
  the rules are absent by design, and skaters hold full skate speed for the
  whole match (no stamina variable anywhere; `SKATE_SPEED` is a single
  constant).
- **A checked zombie is flattened for 2 seconds and drops the puck** —
  `scripts/player.gd`: `STUN_SECONDS := 2.0`; `check_opponent()` sets the
  opponent's `stun_timer = STUN_SECONDS` and clears their `has_puck`.
- **Aimed shooting, goalie guards the middle** — `scripts/player.gd`:
  `shoot_puck()` aims for a corner when Up/Down is held; `_goalie_move()`
  tracks the puck and is too slow to cover a corner shot.
- **A full match to a result** — `scripts/match.gd`: 3 periods × 3 minutes,
  sudden-death overtime, then a best-of-3 shootout; the result screen shows
  the final score.

Status: **code-verified by reading the scripts in this repo.** Playtest on
real hardware is still pending (below) — the rules are in the build, but no
player has run them yet, so do not claim they are proven fun until the
checklist below is ticked off from a real PC.

## Team-select scene

There is no team-select scene in the locked single-match slice, and none is
planned for it: the main menu (`scenes/main.tscn`) offers PLAY MATCH,
CONTROLS & MIN SPEC, and BUILD SHEET, and a match is always Montreal
Cadaviens (home) vs Detroit Dread Wings (away). VEX's "team-select scene not
run" is therefore not an untested scene — it is a scene that does not exist.
If a team-select screen is ever added, it must be run on PC hardware and its
result recorded here before the next review.

## Target-device checklist (PC hardware — not yet run)

Run the locked loop on two different PCs and record the results in the
two-machine test log in `docs/CONTROLS_AND_MIN_SPEC.md` (that table is the
single place for machine results — it is not duplicated here):

- [ ] Full match played start to finish on PC, gamepad first: skate → pass →
  shoot/check → score, periods running, overtime/shootout if tied, result
  screen shown.
- [ ] Zombie rules observed in play: a check flattens a zombie for about 2
  seconds and the puck comes loose; no offsides or icing stoppage ever
  appears; no stamina slowdown late in the match.
- [ ] Main menu → PLAY MATCH with no dead ends; pause unpauses and R restarts.
- [ ] 60-second capture recorded (see `docs/CAPTURE_CHECKLIST.md`).
- [ ] Fresh-player playtest done with three players who have never seen the
  game (protocol in `docs/CONTROLS_AND_MIN_SPEC.md`).

Status: **not yet run on real hardware.** Do not claim the loop or the zombie
rules are proven until the checklist is ticked off from a real PC.
