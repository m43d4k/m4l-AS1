# AGENTS.md

## Goal

Build and maintain a TORAIZ AS-1 Max for Live MIDI Effect that selects programs with
Bank Select LSB and Program Change.

## Source Of Truth

- Target behavior: `SPEC.md`
- MIDI evidence and hardware checks: `AS1_MIDI_REFERENCE.md`
- Existing wiring details: `patching-notes.md`

Do not infer target behavior from implementation constants or tests.

## Target Model

- Banks: `U1-U5`, `F1-F5`
- 99 programs per bank
- `CC#32`: `0-9`
- Program Change: `0-98`
- Delay: `0 / 5 / 10 ms`
- MIDI thru with `[midiin] -> [midiout]`

## Implementation Rules

- Use Max `[v8]` for controller logic.
- Keep the parent shell in `bank-program-changer_dev.amxd`.
- Keep visible UI in `ui_as1.maxpat` and non-UI wiring in `logic_as1.maxpat`.
- Do not reintroduce a separately managed parent `.maxpat`.
- Generate raw MIDI bytes in JavaScript and send through `[midiout]`.
- Use distinct action (`---ui-*-action`) and sync (`---ui-*`) buses.
- Use `set_*` sync messages to avoid UI feedback loops.
- Keep `bankIndex` and `pcDisplay` as the program-selection source of truth.
- Bank changes reset Program to 1 and send.
- Program edits send after updating state.
- Increase/Decrease wrap and send.
- Do not add AS-1 parameter editing, SysEx, or librarian behavior without expanding `SPEC.md`.

## Verification Rules

- Automated tests must cover every bank boundary, U5/F1, and full-range wrap.
- Patch tests must verify ten bank labels and Program limits.
- Do not claim Max, Live, or hardware verification unless it was performed there.
- Record hardware results, especially U5/F1 mapping and required delay, in
  `AS1_MIDI_REFERENCE.md`.
