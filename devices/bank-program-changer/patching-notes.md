# bank-program-changer patching notes

## Core Wiring

- Parent hosts `ui_as1.maxpat` and `logic_as1.maxpat` in `[bpatcher]` objects.
- `logic_as1.maxpat` keeps `[midiin] -> [midiout]` MIDI thru.
- Bank: `---ui-bankindex-action` -> `prepend bankindex` -> controller.
- Program: `---ui-pc-action` -> `prepend pc` -> controller.
- Delay: `---ui-delay-action` -> `prepend delay` -> controller.
- MIDI Clock Mode: `---ui-clockmode-action` -> `prepend clockmode` -> controller.
- Increment, decrement, send, and restore messages go directly to the controller.

Action buses and UI-sync buses remain separate to prevent feedback loops.

## UI Sync

Controller outlet 1 is routed with:

```text
route set_bankindex set_pc set_delay set_clockmode
```

The branches update `---ui-bankindex`, `---ui-pc`, `---ui-delay`, and
`---ui-clockmode` with `set`-style messages.

## State Restore

Bank, Program, Delay, and MIDI Clock Mode are Live parameters in `ui_as1.maxpat`. The parent
`live.thisdevice` trigger starts a restore window. The child patch sends
`outputvalue` after 50 ms and again after 200 ms, then ends the window at 260 ms.
The controller restores the program selection and MIDI Clock Mode without UI feedback loops.

## MIDI Clock Mode

- The external label is `SEQ`; the `live.text` toggle displays `SYNC` and `MANUAL`.
- NRPN `1027` sends value `2` for `Slave` and `4` for `SlaveNo S/S`.
- A clock-mode change does not resend Bank Select or Program Change.

There is no second persistence path in JavaScript.

## Delay Behavior

- Delay menu indexes map to `0`, `5`, and `10` ms.
- CC#32 is sent immediately; Program Change may be delayed.
- Only the latest delayed Program Change is retained.
- Changing Delay reschedules a pending Program Change without resending CC#32.

## Loop Behavior

- `U1 / 99` + `inc` -> `U2 / 1`.
- `F5 / 99` + `inc` -> `U1 / 1`.
- `U1 / 1` + `dec` -> `F5 / 99`.
