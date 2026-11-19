# Controls and Minimum Spec

## Keyboard controls

| Action | Key |
| --- | --- |
| Skate | WASD or arrow keys |
| Pass | Space |
| Shoot | J |
| Check | K |
| Switch skater | Tab |
| Pause | Esc |
| Restart match | R (on pause / result screen) |

## Controller controls

| Action | Input |
| --- | --- |
| Skate | Left stick |
| Pass | X (Xbox) / Square (PlayStation) |
| Shoot | A (Xbox) / Cross (PlayStation) |
| Check | B (Xbox) / Circle (PlayStation) |
| Switch skater | Y (Xbox) / Triangle (PlayStation) |
| Pause | Start / Options |

Controller input is defined in `project.godot` (`[input]` section) so keyboard
and controller share the same actions (`move_up`, `move_down`, `move_left`,
`move_right`, `pass`, `shoot`, `check`, `switch_player`, `pause`).

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

## Two-machine test log

Test the locked loop (skate → pass → shoot/check → score) on two different
machines and record the result here before the next review.

| Machine | CPU / GPU / RAM | Resolution / preset | FPS (avg) | Loop playable? | Notes |
| --- | --- | --- | --- | --- | --- |
| Machine 1 | _not yet tested_ | _—_ | _—_ | _—_ | _—_ |
| Machine 2 | _not yet tested_ | _—_ | _—_ | _—_ | _—_ |

Status: **not yet tested — do not claim the spec is verified until both rows
are filled in from real hardware.**
