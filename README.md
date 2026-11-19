# Zombie Hockey League

> Skate, check, and score in one locked arcade zombie-hockey match.

**Platform:** PC (Windows via Steam) · **Category:** Sports · **Engine:** Godot 4

## Tester review — the reason for this update

A game tester reviewed the build and scored it **2.5/10 (grade F)**. This update is
fix-first: no new features until the five fixes below are applied to the existing
project.

## The five fixes (highest priority first)

1. **Write a one-page build sheet first** — 30-second loop, match length, win/lose
   condition, controls, and exactly one mode. Publish that before adding any new
   feature. See [`docs/BUILD_SHEET.md`](docs/BUILD_SHEET.md).
2. **Lock one identity and cut the rest** — arcade league match. Manager sim and
   tower defence are cut. The build sheet lists three things this game is NOT,
   to stop scope creep.
3. **Capture 60 seconds of the locked loop on real PC hardware** and attach it to
   the next review — no trailer polish, just skating, shooting/checking, and scoring.
4. **Define the control scheme and minimum PC target in writing** (keyboard and
   controller, plus a spec benchmark comparable to Wild Ice's i3-6100 / GTX 750 Ti
   floor) and test it on two different machines.
   See [`docs/CONTROLS_AND_MIN_SPEC.md`](docs/CONTROLS_AND_MIN_SPEC.md).
5. **Write the one-sentence differentiation** from Wild Ice and Mutant League
   Hockey, then put price, demo plan, and a Steam page date behind it.

## What this build contains

- `docs/BUILD_SHEET.md` — the one-page build sheet (fix #1, published first).
- `docs/CONTROLS_AND_MIN_SPEC.md` — keyboard + controller scheme, minimum spec,
  and the two-machine test log (fix #4).
- `project.godot` — Godot 4 project definition, input map, and Windows export settings.
- `scenes/main.tscn` — main menu and match entry.
- `scenes/rink.tscn` — playable rink skeleton with goals, puck, and skaters.
- `scripts/player.gd` — skating, passing, shooting, checking, and player switching.
- `BUILD-PLAN.md` — the full plan: features, stack, milestones, and open questions.

## How to run

1. Open this folder in Godot 4.
2. Press F5 (or Play) — the main scene is `scenes/main.tscn`.
3. From the menu, start a match: skate with WASD / arrow keys or the left stick,
   pass with Space / X, shoot with J / A, check with K / B, switch skater with
   Tab / Y, pause with Esc / Start.

## Status

Fix-first update in progress. The loop (skate → pass → shoot/check → score) is a
playable skeleton; the 60-second capture (fix #3) and the two-machine test log
(fix #4) are still open until recorded on real hardware.
