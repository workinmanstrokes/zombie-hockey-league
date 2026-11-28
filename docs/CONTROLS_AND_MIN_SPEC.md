# Controls and Minimum Spec

Gamepad-first: the game is designed and tested on a controller first, with the
keyboard as a fallback. Both feed the same actions in `project.godot`
(`[input]` section): `move_up`, `move_down`, `move_left`, `move_right`,
`pass`, `shoot`, `check`, `switch_player`, `pause`.

## Controller controls (primary)

| Action | Input |
| --- | --- |
| Skate | Left stick |
| Pass | X (Xbox) / Square (PlayStation) |
| Shoot | A (Xbox) / Cross (PlayStation) — hold Up/Down while shooting to aim for a corner; the goalie guards the middle |
| Check | B (Xbox) / Circle (PlayStation) — flattens a zombie for 2 seconds and knocks the puck loose |
| Switch skater | Y (Xbox) / Triangle (PlayStation) |
| Pause | Start / Options |

## Keyboard controls (fallback)

| Action | Key |
| --- | --- |
| Skate | WASD or arrow keys |
| Pass | Space |
| Shoot | J — hold Up/Down (W/S or arrow keys) while shooting to aim for a corner |
| Check | K |
| Switch skater | Tab |
| Pause | Esc |
| Restart match | R (on pause / result screen) |

## Stick dead zone and switching (VEX fix)

- **Dead zone 0.2:** `scripts/player.gd` reads the left stick with
  `Input.get_vector(..., STICK_DEADZONE)` where `STICK_DEADZONE := 0.2`, so
  stick drift below 0.2 never skates the active skater, and the same dead
  zone applies to the Up/Down aim while shooting. Keyboard input is digital
  and is unaffected.
- **Switching reads at a glance:** `scripts/match.gd` `_set_active_skater()`
  sets the active home skater to full brightness and dims the other home
  skaters to 0.6, so it is always obvious which zombie answers the stick.
  A switch cycles the three home skaters in order; it does nothing during a
  shootout or after the final whistle.
- **Missed inputs:** pass, shoot, check, and switch all fire on
  `is_action_just_pressed`, so one press is one action — a held button does
  not repeat the action. Check has a 0.8-second cooldown by design.

## Touch controls

None — there are no touch controls in this game, and none are planned. The
target device is PC (Windows via Steam); VEX's "touch controls" items are
answered by the gamepad-first scheme above and the keyboard fallback, which
are the controls the target device actually has.

## Minimum PC target

Benchmark floor comparable to Wild Ice's i3-6100 / GTX 750 Ti floor:

- **CPU:** Intel Core i3-6100 (or equivalent)
- **GPU:** NVIDIA GeForce GTX 750 Ti (or equivalent)
- **RAM:** 8 GB
- **OS:** Windows 10 64-bit
- **Storage:** 2 GB available space
- **Target:** 60 fps at 1280×720 on the Low preset

## Low-spec performance preset

- Resolution 1280×720, fullscreen off by default on first run below the target spec
- Shadows off, particles reduced, crowd/ambient animation off
- Fixed 60 fps cap; physics tick matched to the display refresh
- One rink, one match, no background simulation while a match is running
- The match HUD shows a live FPS readout, so the 60 fps target is visible in the 60-second capture

## Fresh-player playtest protocol

Before the next review, three players who have never seen the game each play
one full match on a gamepad, with no instructions beyond the in-game Controls
screen. Record: time to first goal, whether they found pass / shoot / check /
switch without help, and anything that confused them. Their notes go into
fixes before the next review.

| Player | Has not seen the game before? | Time to first goal | Found all controls unaided? | Confusion / notes |
| --- | --- | --- | --- | --- |
| Player 1 | _not yet tested_ | _—_ | _—_ | _—_ |
| Player 2 | _not yet tested_ | _—_ | _—_ | _—_ |
| Player 3 | _not yet tested_ | _—_ | _—_ | _—_ |

## Two-machine test log

Test the locked loop (skate → pass → shoot/check → score) on two different
machines and record the result here before the next review.

| Machine | CPU / GPU / RAM | Resolution / preset | FPS (avg) | Loop playable? | Notes |
| --- | --- | --- | --- | --- | --- |
| Machine 1 | _not yet tested_ | _—_ | _—_ | _—_ | _—_ |
| Machine 2 | _not yet tested_ | _—_ | _—_ | _—_ | _—_ |

Status: **not yet tested — do not claim the spec is verified until both rows
are filled in from real hardware.**
