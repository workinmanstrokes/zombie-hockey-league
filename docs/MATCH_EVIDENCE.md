# Match Evidence — What the Code Proves, and What It Does Not

VEX (Game Test Lab, 3/10, grade D) listed as weaknesses that no shooting,
passing, AI, goalie, scoring, period flow, or win/lose state was described.
Every one of those exists in this repo's scripts. This file pins each
element to the exact code, so the next review judges the build that is
actually here — and says plainly what is still unproven.

## The core loop, pinned to code

| Element | Where it lives | What it does |
| --- | --- | --- |
| Skating | `scripts/player.gd` `_player_move()` | Left stick / WASD, `SKATE_SPEED` 320, accel 1800; left-stick dead zone 0.2 |
| Passing | `scripts/player.gd` `pass_puck()` | Passes to the nearest teammate at speed 480; the puck is picked up on contact |
| Shooting (aimed) | `scripts/player.gd` `shoot_puck()` | Shot speed 700; hold Up/Down to aim for a corner — the goalie guards the middle |
| Checking | `scripts/player.gd` `check_opponent()` | In range (64 px), 0.8 s cooldown; flattens the victim for 2 s, knocks the puck loose, pops limb debris |
| Player switching | `scripts/match.gd` `switch_active_skater()` | Cycles the three home skaters; the active skater is full brightness, teammates dimmed |
| AI opponents | `scripts/player.gd` `_chase_puck()` | Away skaters chase the puck at 85% speed; the away shooter in a shootout shoots after 1 s with a random aim |
| Goalie | `scripts/player.gd` `_goalie_move()` | Tracks the puck's height once it is close (220 px); too slow to cover a corner shot |
| Scoring | `scripts/match.gd` `_check_goal()` / `_on_goal()` | A goal counts only inside the goal mouth (y 300–420); a goal resets to centre ice |
| Period flow | `scripts/match.gd` `_end_period()` | 3 periods × 3 minutes; most goals wins |
| Overtime | `scripts/match.gd` | 2 minutes sudden death, first goal wins; plays under a FULL MOON cue |
| Shootout | `scripts/match.gd` `_start_shootout()` | Best of 3 rounds, then sudden-death rounds; 8 seconds per attempt |
| Win / lose | `scripts/match.gd` `_end_match()` | Result screen: winner, final score, shootout detail if any; R restarts |
| Pause / restart | `scripts/match.gd` `_set_paused()` / `_restart_match()` | Start/Esc pauses (and unpauses); R restarts from anywhere |
| Performance | `scripts/match.gd` `_update_hud()` | Live FPS readout in the HUD, so the 60 fps target is visible in the capture |

## What this evidence is not

This is **code evidence, not play evidence**. Reading the scripts proves
the loop is built; it does not prove it is fun, readable, or running at
60 fps on the minimum spec. The following are still open and are not
claimed here — they are the checklist in `docs/TEST_LOG.md`:

- A full match played start to finish on real PC hardware, gamepad first.
- The zombie rules observed in play (2-second flatten, puck coming loose).
- The 60-second capture on real hardware.
- The two-machine test log filled in from real hardware.
- The fresh-player playtest with three players who have never seen the game.

## Target-device correction

VEX's items describe a "phone project" with "touch controls". There is no
phone build of this game: the target device is PC (Windows via Steam,
Godot 4) and the only build is the Windows Desktop export
(`export_presets.cfg`). The controls evidence above is therefore gamepad
and keyboard, on PC — the controls the target device actually has. The
roster file for the two slice teams is `data/teams.json`; there is no
team-select screen in the slice, and none is claimed to have been run.
