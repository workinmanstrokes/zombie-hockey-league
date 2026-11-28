# Zombie Rules — Frozen Register

VEX (Game Test Lab, 3/10, grade D) flagged that seven zombie systems exist
before core hockey is proven, and that the rules were tested only in a copy,
not in this project. This register is the answer: what is live in this repo,
what is frozen, what is cut, and the exact gate for re-enabling anything.

## Live in this build (pinned to the code)

- **No offsides, no icing, no stamina** — `scripts/match.gd` and
  `scripts/player.gd` contain no offsides, icing, or stamina logic at all.
  Skaters hold full skate speed for the whole match.
- **A checked zombie is flattened for 2 seconds and drops the puck** —
  `scripts/player.gd`: `STUN_SECONDS := 2.0`; `check_opponent()` sets the
  opponent's `stun_timer`, clears their `has_puck`, and now also lies the
  zombie flat (rotated 90 degrees) and pops a limb-debris marker loose.
- **Aimed shooting, goalie guards the middle** — `scripts/player.gd`:
  `shoot_puck()` aims for a corner when Up/Down is held; `_goalie_move()`
  tracks the puck and is too slow to cover a corner shot.

Status: **code-verified by reading the scripts in this repo.** Playtest on
real PC hardware is still pending — see `docs/TEST_LOG.md`. Do not claim
the rules are proven fun until the checklist there is ticked off from a
real PC.

## Frozen — re-enable one at a time, and only after the gate below

VEX named two rules for re-enabling first — **Rage** and **Infection** —
and said the other systems in the review are not named there and are not in
this repo, so no further rule names are added here. Neither Rage nor
Infection is in the build, and neither gets a definition invented here: the
maker writes each rule's one-paragraph definition (what triggers it, what
it changes, how long it lasts) before it is coded, and each rule is then
added alone and playtested alone before the next one is touched.

**The gate (frozen until all of it is true):**

1. One full match is fun without any new zombie rule — judged by the
   fresh-player playtest in `docs/CONTROLS_AND_MIN_SPEC.md` (three players
   who have never seen the game each finish a full match).
2. The 60-second capture is recorded on real PC hardware.
3. The two-machine test log is filled in from real hardware.

## Cut — the 5-second bite-or-brawl

**CUT, not simplified.** VEX flagged it as the rule most likely to stop
hockey flow, and it does: it freezes play for 5 seconds. A rule that stops
the skate → pass → shoot/check → score loop for 5 seconds has no place in
a 9-minute arcade match. It is not in the code, and it is not to be
re-added under another name without the maker explicitly reversing this
cut in writing.

## League / playoff and monetisation — decided, gated the same way

No league or playoff structure is built until the single match passes the
gate above. The structure is already decided in writing
(`docs/BUILD_SHEET.md`): eight teams play each other once, top two meet in
a one-match final. Monetisation is already decided in writing: one-time
purchase, no pay-to-win, the full league inside the base price
(`docs/BUILD_SHEET.md`, `docs/RELEASE_PATH.md`). Nothing about the league
or the price changes in this update.
