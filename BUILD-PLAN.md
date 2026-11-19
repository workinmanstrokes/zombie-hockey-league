# Zombie Hockey League — Build Plan

- **Name:** Zombie Hockey League
- **Kind:** game (update to an existing project, not a new game)
- **Platform:** PC (Windows via Steam)
- **Category:** Sports
- **Tagline:** Skate, check, and score in one locked arcade zombie-hockey match.
- **Stack:** Godot 4 — exports Windows for Steam, has built-in controller input
  and arcade physics, and lets a solo maker strip and ship one mode without a
  heavy engine pipeline.

## Summary

A fix-first update for the existing PC Zombie Hockey League after a 2.5/10 (F)
tester review. No new features until a one-page build sheet is published, one
identity — arcade league match — is locked and the other modes are cut, the core
skate/shoot/check/score loop is playable, keyboard and controller controls plus
an i3-6100 / GTX 750 Ti minimum spec are defined and tested on two machines, and
60 seconds of unpolished gameplay is captured for the next review. The update
ends with a one-sentence differentiation from Wild Ice and Mutant League Hockey,
plus price, demo plan, and a Steam page date.

## Features

- Single locked arcade league match mode only — manager sim and tower defence removed
- Skating, passing, shooting, checking and scoring on one rink
- Timed match with most-goals-wins, overtime/shootout on a tie
- Keyboard controls for skate, pass, shoot and check
- Controller support with stick movement and button shoot/check/pass
- Player switching between zombie skaters on the active team
- Pause, restart and match-end result screen
- Low-spec performance preset targeting i3-6100 / GTX 750 Ti at 60fps
- In-repo build sheet, controls and minimum-spec document for the next review

## Screens

- Main Menu
- Match — Rink
- Pause Menu
- Controls and Minimum Spec
- Match Result
- Build Sheet / About

## Entities

Match, Team, Zombie Skater, Goal Event, Match Result, Control Binding,
Build Sheet, Machine Test Result.

## Milestones

1. Publish the one-page build sheet and lock arcade league match as the only
   identity, listing three things the game is NOT.
2. Strip the build to a playable skeleton: skate, pass, shoot, check and score
   on one rink with a timed win/lose result.
3. Freeze keyboard and controller controls and the low-spec preset, then test
   the loop on two different PCs.
4. Capture 60 seconds of unpolished gameplay on real hardware — skating,
   shooting/checking and scoring — and attach it to the next review.
5. Write the one-sentence differentiation from Wild Ice and Mutant League
   Hockey, then set price, demo plan and Steam page date.

## Starter files in this commit

| File | Purpose |
| --- | --- |
| `README.md` | Project overview, tester score, and the five fixes |
| `project.godot` | Godot project definition, input map, Windows export settings |
| `docs/BUILD_SHEET.md` | One-page build sheet: 30-second loop, match length, win/lose, controls, single locked mode |
| `docs/CONTROLS_AND_MIN_SPEC.md` | Keyboard and controller scheme, i3-6100/GTX 750 Ti minimum target, two-machine test log |
| `scenes/main.tscn` | Main menu and match entry scene |
| `scenes/rink.tscn` | Playable rink skeleton with goals, puck and skaters |
| `scripts/player.gd` | Skating, shooting, checking and player-switching controls |

## Open questions (maker to answer)

- Which identity will the maker lock in — arcade league match is the recommended
  default, but manager sim or tower defence would change the build entirely?
  (This plan locks arcade league match; changing it reopens the build sheet.)
- What engine/codebase does the existing project use — if it is not Godot, the
  stack and starter files must change to match it?
- What is the exact match length and period structure to lock in the build sheet?
  (This plan locks 3 periods × 3 minutes = 9 minutes, pending maker confirmation.)
- What price and Steam page date will the maker commit to? (Recorded as TBD in
  `docs/BUILD_SHEET.md` until the maker decides — no price or date is invented here.)
