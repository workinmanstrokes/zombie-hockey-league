# Zombie Hockey League — Build Sheet (one page)

**Locked identity: arcade league match. Exactly one mode.**

Short version (under 200 words): see [`docs/BUILD_BRIEF.md`](BUILD_BRIEF.md).

## The 30-second loop

Skate to the puck → pass or carry up the rink → shoot or check → score (or lose
the puck) → reset to the faceoff / next shift. Every 30 seconds of play must
contain skating, a pass or a shot, and a check or a scoring chance. If a
30-second stretch has none of those, the loop is broken.

## Match length

**3 periods × 3 minutes = 9 minutes of regulation.** Clock runs during play.
Most goals at the final whistle wins. On a tie: 2 minutes of sudden-death
overtime (first goal wins), then a shootout (best of 3 rounds, then sudden-death
rounds) if still tied.

## League season (defined, not yet built)

Eight zombie teams play each other once: Montreal Cadaviens, Detroit Dread
Wings, Boston Brains, New York Ravagers, Philadelphia Flayers, Pittsburgh
Pen-Ghouls, Edmonton Oozers, Buffalo Scabs. A win earns 2 points, an overtime
or shootout win earns 1, a loss earns 0. The top two teams meet in a one-match
final. The vertical slice in this repo plays ONE match (Cadaviens vs Dread
Wings). The season table, standings, and final are defined here so the design
is complete, but no season code ships until the single match plays cleanly
end to end — "League" in the title must not become a multi-team build before
one match works.

## Win / lose condition

- **Win:** more goals than the opponent when the match ends (regulation, overtime, or shootout).
- **Lose:** fewer goals. There is no draw — overtime/shootout always decides it.
- **Shootout:** best of 3 rounds, alternating shots, then sudden-death rounds. Aim for a corner — the goalie guards the middle.
- **Result screen:** final score, goals per period, and shots on goal.

## Controls (summary — full scheme in `docs/CONTROLS_AND_MIN_SPEC.md`)

- **Controller (first):** left stick to skate, X to pass, A to shoot, B to check,
  Y to switch skater, Start to pause.
- **Keyboard (fallback):** WASD / arrows to skate, Space to pass, J to shoot, K to check,
  Tab to switch skater, Esc to pause.

## The one mode — and what this game is NOT

**This game IS:** one arcade league match on one rink — skate, pass, shoot,
check, score, win or lose in 9 minutes.

**This game is NOT:**

1. **Not a manager sim** — no front office, no trading, no season finances.
2. **Not tower defence** — no waves, no towers, no base to defend.
3. **Not a story / career RPG** — no dialogue, no levelling campaign, no
   off-rink progression. The match is the game.

Any feature that does not serve the 9-minute arcade match is cut.

## Visual and audio direction

See [`docs/DIRECTION.md`](DIRECTION.md): chunky flat-colour arcade look, one
rink, undead teams in green (home) and red (away), organ sting on goals. The
current build uses coloured-rectangle placeholder sprites — that is not the
finished look.

## Differentiation (one sentence)

Zombie Hockey League is one 9-minute arcade zombie-hockey match — skate,
check, score, done — where Mutant League Hockey is a retro parody built on
jokes, Wild Ice is a realistic sim with tower defence launching 19 August 2026,
Super Blood Hockey is 4v4 arcade hockey built around brawls and fights, and
Zombie Hockey Manager is a management game. This game wins on speed and
simplicity: 3v3, zombie rules (no offsides, no icing, no stamina, a checked
zombie stays down 2 seconds), and the first match delivers the whole game:
no managing, no building, no story, no brawling.

## Price, demo, Steam page

- **Monetisation (decided):** one-time purchase for the full PC game. No
  pay-to-win, no microtransactions, no paid DLC, no in-game purchases of any
  kind.
- **Scope tied to the price:** the full 8-team league — season table,
  standings, and the one-match final — ships inside that one purchase, once
  the single match plays cleanly. Nothing in the league is held back behind a
  second payment, and no paid extra is planned, so the price caps the scope:
  the game cannot grow by adding paid parts.
- **Price figure:** TBD — the maker sets the dollar figure before the Steam
  page goes live. No figure is invented here.
- **Demo plan:** a playable one-match demo once the 60-second capture
  passes review; target is ahead of Wild Ice's 19 August 2026 launch —
  exact date maker to confirm.
- **Steam page date:** TBD — maker to confirm.
- **Release path:** PC (Windows) via Steam. A Windows export preset
  (`export_presets.cfg`) is in the repo so a verifiable build can be produced
  from Godot 4.3; no binary is checked in.

## Next review evidence (fix #3)

60 seconds of unedited gameplay captured on real PC hardware — skating,
shooting/checking, and scoring — must be attached to the next review.
Checklist: [`docs/CAPTURE_CHECKLIST.md`](CAPTURE_CHECKLIST.md). The match HUD
now shows a live FPS readout so the 60 fps target is visible in the capture.
Status: **not yet captured**. The target-device test log — zombie rules pinned
to the code, and what must be run on real PC hardware — is
[`docs/TEST_LOG.md`](TEST_LOG.md).
