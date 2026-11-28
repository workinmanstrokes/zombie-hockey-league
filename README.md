# Zombie Hockey League

> Skate, check, and score in one locked arcade zombie-hockey match.

**Platform:** PC (Windows via Steam) · **Category:** Sports · **Engine:** Godot 4

## Tester reviews — the reason for these updates

- A game tester reviewed the build and scored it **2.5/10 (grade F)**. That review drove the fix-first update: a one-page build sheet, one locked mode, and controls plus a minimum spec in writing.
- VEX (Game Test Lab) then scored it **3.5/10 (grade D)** — "a title in search of a playable game". This update answers that review: a sub-200-word build brief, a real vertical slice (one rink, two zombie teams of three, a full match to the final whistle with periods, sudden-death overtime, and a shootout), gamepad-first controls, a one-line differentiation, and a Windows export preset so a verifiable build can be produced.
- A follow-up update answers VEX’s four remaining items: the monetisation decision in writing (one-time purchase, no pay-to-win, full league in the base price), Super Blood Hockey added to the differentiation, the zombie rules pinned to the code in this repo, and a PC target-device test log (`docs/TEST_LOG.md`). Note: VEX’s items 3–4 refer to a "phone build" — there is no phone build; the target device is PC (Windows via Steam), and the test log corrects that.
- The latest update answers VEX’s remaining flag — no release path stated — with a gated release path in [`docs/RELEASE_PATH.md`](docs/RELEASE_PATH.md): 60-second capture → free one-match demo → Steam page → 1.0 launch, with what validates demand at each step. The price figure, demo date, and Steam page date are still the maker’s calls and are recorded as open decisions there, not invented.
- This update corrects the Wild Ice references now that it has launched (19 August 2026 on Steam, free demo, split-screen co-op): the one-sentence differentiation and the demo-date target in `docs/BUILD_SHEET.md` and `docs/RELEASE_PATH.md`. The old “ahead of Wild Ice’s launch” demo target lapsed when Wild Ice went live, so the maker must set a new target date. Still open and still the maker’s items, not invented here: the 60-second capture, the two-machine test log, the price figure, the demo date, and the Steam page date.

## The vertical slice (this update)

- One rink, two teams of three: Montreal Cadaviens (home, green) vs Detroit Dread Wings (away, red).
- Full match: 3 periods × 3 minutes, most goals wins, sudden-death overtime, then a shootout (best of 3 rounds, then sudden-death rounds).
- Core loop: skate → pass → shoot/check → score. Loose pucks can be picked up; a check flattens a zombie for 2 seconds and knocks the puck loose.
- Shooting is aimed: hold Up/Down while shooting to pick a corner — the goalie guards the middle.
- Live FPS readout in the match HUD, so the 60 fps target is visible in the capture.
- Pause now actually unpauses (the match node keeps processing while paused); R restarts from anywhere.

## The fixes (highest priority first)

1. **Write a one-page build sheet first** — 30-second loop, match length, win/lose
   condition, controls, and exactly one mode. Publish that before adding any new
   feature. See [`docs/BUILD_SHEET.md`](docs/BUILD_SHEET.md) and the sub-200-word
   [`docs/BUILD_BRIEF.md`](docs/BUILD_BRIEF.md).
2. **Lock one identity and cut the rest** — arcade league match. Manager sim and
   tower defence are cut. The build sheet lists three things this game is NOT,
   to stop scope creep.
3. **Capture 60 seconds of the locked loop on real PC hardware** and attach it to
   the next review — no trailer polish, just skating, shooting/checking, and scoring.
   Checklist: [`docs/CAPTURE_CHECKLIST.md`](docs/CAPTURE_CHECKLIST.md).
4. **Define the control scheme and minimum PC target in writing** (gamepad-first,
   keyboard fallback, plus a spec benchmark comparable to Wild Ice’s i3-6100 / GTX 750 Ti
   floor) and test it on two different machines, with three fresh players who have
   never seen the game. See [`docs/CONTROLS_AND_MIN_SPEC.md`](docs/CONTROLS_AND_MIN_SPEC.md).
5. **Write the one-sentence differentiation** from Wild Ice, Super Blood Hockey,
   Mutant League Hockey, and Zombie Hockey Manager, then put the decided
   monetisation (one-time purchase, no pay-to-win), demo plan, and a Steam page
   date behind it — now stated as a gated release path in
   [`docs/RELEASE_PATH.md`](docs/RELEASE_PATH.md).

## What this build contains

- `docs/BUILD_BRIEF.md` — the sub-200-word build brief (VEX fix #1).
- `docs/BUILD_SHEET.md` — the one-page build sheet, season format, differentiation, and price/demo/Steam plan.
- `docs/RELEASE_PATH.md` — the release path (VEX fix): capture → free one-match demo → Steam page → 1.0 launch, with entry/exit criteria per gate and the three maker decisions (price figure, demo date, Steam page date) named, not invented.
- `docs/DIRECTION.md` — visual direction, rink and zombie design, audio direction.
- `docs/CAPTURE_CHECKLIST.md` — the 60-second capture checklist.
- `docs/CONTROLS_AND_MIN_SPEC.md` — gamepad-first scheme, minimum spec, fresh-player protocol, and the two-machine test log.
- `docs/TEST_LOG.md` — the target-device test log: zombie rules pinned to the code, the no-phone-build correction, and the PC checklist.
- `export_presets.cfg` — Windows Desktop export preset (Godot 4.3 templates required).
- `project.godot` — Godot 4 project definition, input map, and Windows export settings.
- `scenes/main.tscn` — main menu and match entry.
- `scenes/rink.tscn` — playable rink: two teams of three, goals, puck, HUD with FPS and result.
- `scripts/player.gd` — skating, passing, shooting, checking, player switching, stun, puck carry/pickup.
- `scripts/match.gd` — periods, overtime, shootout, pause, restart, switching, FPS.
- `BUILD-PLAN.md` — the full plan: features, stack, milestones, and open questions.

## How to run

1. Open this folder in Godot 4.3.
2. Press F5 (or Play) — the main scene is `scenes/main.tscn`.
3. From the menu, start a match: gamepad left stick to skate, X pass, A shoot (hold Up/Down to aim a corner), B check, Y switch skater, Start pause. Keyboard fallback: WASD / arrows, Space pass, J shoot, K check, Tab switch, Esc pause, R restart.

## How to build (Windows)

1. In Godot, install the export templates (Editor > Manage Export Templates).
2. Project > Export > Windows Desktop — the "Windows Desktop" preset exports to `../builds/zombie-hockey-league.exe`.
3. No binary is checked into the repo; the exported build is the verifiable build for the next review.

## Status

Fix-first update in progress. The vertical slice (3v3, periods, OT, shootout) is in the code; the 60-second capture, the fresh-player playtest, and the two-machine test log are still open until recorded on real hardware. Monetisation is decided in writing (one-time purchase, no pay-to-win, the full league in the base price) and the release path is now stated in `docs/RELEASE_PATH.md`; the dollar figure, demo date, and Steam page date are still the maker’s calls.
