# Zombie Hockey League — Release Path

**Store:** Steam (PC, Windows). **Model:** one-time purchase, no pay-to-win, no microtransactions, no paid DLC — the full 8-team league ships in the base price once the single match plays cleanly (see `docs/BUILD_SHEET.md`).

This answers VEX (Game Test Lab, 3.5/10): the release path was not stated. It is now, as four gated steps — each gate names what must be true before the next one starts, and what demand signal it validates. The three figures only the maker can set (price, demo date, Steam page date) are named as open decisions below; none is invented here.

## Gate 0 — Playable match (in progress)

- **Exit criteria:** one 9-minute arcade match (3v3, 3 periods, overtime, shootout) plays end to end on two PCs at 60 fps on the i3-6100 / GTX 750 Ti minimum spec; 60 seconds of unedited gameplay captured on real hardware (`docs/CAPTURE_CHECKLIST.md`, `docs/TEST_LOG.md`).
- **Validates:** that the loop is a game at all — no demo or store page is worth anything before this.

## Gate 1 — Playable demo (validates demand)

- **What ships:** the one-match demo — Montreal Cadaviens vs Detroit Dread Wings, the full 9-minute match, same controls, no season table yet.
- **Entry:** Gate 0 exit criteria met and the 60-second capture passes review.
- **Where it goes:** free demo on the Steam page once the page is live; until then, a direct download link from a repo release.
- **Validates:** whether players finish a match, replay it, and ask for the league — before any money is asked.
- **Demo date:** the old target (ahead of Wild Ice’s 19 August 2026 launch) has lapsed — Wild Ice launched 19 August 2026 and is live on Steam with a free demo and split-screen co-op. Exact date: **maker to confirm — not set here.**

## Gate 2 — Steam page (validates demand, collects wishlists)

- **What the page needs:** capsule art, the one-sentence differentiation (`docs/BUILD_SHEET.md`), the 60-second capture, the minimum spec (i3-6100 / GTX 750 Ti, from `docs/CONTROLS_AND_MIN_SPEC.md`), the one-time-purchase price, and the demo.
- **Entry:** demo playable (Gate 1) + capsule art + capture attached.
- **Validates:** wishlist count before launch — the first real demand signal, and the number the launch date is set against.
- **Steam page date:** **maker to confirm — not set here.** The page cannot go live before the price figure is set: a Steam page cannot publish without a price.

## Gate 3 — Launch (1.0)

- **What ships:** the full 8-team league — season table, standings, and the one-match final — inside the one purchase.
- **Entry:** Steam page live, demo out, season table playable end to end, two-machine test log clean.
- **Price figure:** **maker to set before the Steam page goes live — no figure is invented here.**

## Decisions still open (maker only)

- Dollar price figure.
- Demo date.
- Steam page date.

Each gate above names which decision unblocks it, so the path is shippable against even while the figures are open.

## What this path is not

- No early access, no paid demo, no pre-orders, no console build, no phone build. PC (Windows) via Steam only.
- No binary is checked into the repo — the Windows export preset (`export_presets.cfg`) produces the verifiable build from Godot 4.3.
