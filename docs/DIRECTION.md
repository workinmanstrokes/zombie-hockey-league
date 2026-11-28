# Visual and Audio Direction

## Art style

Chunky flat-colour arcade 2D, top-down. Thick shapes, no realism: the ice is
pale blue-white, the boards are dark, the centre line is red. Home skaters are
green, away skaters are red, the puck is black. Everything must read at a
glance from across the room.

## The rink — THE CRYPT

One rink, 1280×720, no scrolling: the full ice is visible at all times. Two
goals (24×120), a centre red line, and the puck drops at centre ice. No crowd
and no arena dressing in the vertical slice — the Low preset keeps ambient
animation off so the frame rate holds on the minimum spec.

The arena is **THE CRYPT**, and the name is on screen from the first seconds
of a match (`ArenaLabel` in `scenes/rink.tscn`, bottom of the HUD), so the
theme is visible before any goal is scored — not just a name in this document.

## The Full Moon cue

Overtime plays under a **FULL MOON**: a `FULL MOON` label appears in the HUD
and the clock reads `FULL MOON OT` for the whole of sudden death
(`scripts/match.gd` `_update_hud()`). The cue is tied to the highest-stakes
part of the match, so it is seen exactly when the game is tensest.

## Zombie design

Two undead teams, visibly different at a glance:

- **Montreal Cadaviens (home, green):** bone-white trim, shambling skate, torn jerseys.
- **Detroit Dread Wings (away, red):** dark red/black, same shamble, glowing eyes.

Zombies never tire (no stamina), and a hard check flattens one for 2 seconds —
now visible in the build: a flattened zombie lies flat (rotated 90 degrees
in `scripts/player.gd`) and a check pops a limb-debris marker loose
(`_spawn_limb_debris()`). That is the limb-popping hit gag in its first
playable form; a proper limb sprite is a later art pass, not in this slice.

## Audio direction (planned, not yet in the build)

- Organ sting on every goal; crowd groan when the home team concedes.
- Coffin-creak horn on every goal: the hook is live — `scripts/match.gd`
  `_play_goal_horn()` plays `$HUD/GoalHorn` in `scenes/rink.tscn` — but no
  audio stream is assigned to it yet, so a build without the asset stays
  silent instead of erroring. Recording the horn is still an open item.
- Skate-scrape loop while moving, a thud on checks, a click on passes.
- No licensed music. Everything mutable from the pause menu (a mute toggle is a later addition).

## Current status

The build uses coloured-rectangle placeholder sprites (green/red skaters,
black puck). This document is the target the sprite pass must match — do not
treat the placeholders as the finished look. What is no longer just a name
in this document: the arena name on screen (THE CRYPT), the Full Moon cue
in overtime, the flattened-zombie + limb-debris hit feedback, and the
goal-horn hook. What is still only a name here: the horn audio itself, the
organ sting, the skate/check/pass sounds, and the finished zombie sprites.
