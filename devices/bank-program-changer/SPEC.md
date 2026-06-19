# TORAIZ AS-1 Bank / Program Changer Specification

## Purpose

MIDI thru を維持しながら、TORAIZ AS-1 に Bank Select LSB と Program Change
を送信してプログラムを選択する Max for Live MIDI Effect を提供する。

## Program Model

AS-1 は10バンクを持ち、各バンクに99プログラムがある。

| UI bank | Kind | CC#32 value | Programs |
|---|---|---:|---:|
| U1 | User | 0 | 1-99 |
| U2 | User | 1 | 1-99 |
| U3 | User | 2 | 1-99 |
| U4 | User | 3 | 1-99 |
| U5 | User | 4 | 1-99 |
| F1 | Factory | 5 | 1-99 |
| F2 | Factory | 6 | 1-99 |
| F3 | Factory | 7 | 1-99 |
| F4 | Factory | 8 | 1-99 |
| F5 | Factory | 9 | 1-99 |

UI は1-based、MIDI data bytes は0-basedとする。

```js
bankSelectLsb = bankIndex;       // 0..9
programChange = pcDisplay - 1;  // 0..98
```

## MIDI Output

送信順序:

1. Bank Select LSB: Control Change `CC#32`, value `0-9`
2. Program Change: value `0-98`

Bank Select と Program Change の間隔は `0 / 5 / 10 ms` から選ぶ。
MIDI channel は Live track の routing と AS-1 の設定を一致させる。

## UI

- Bank selector: `U1 U2 U3 U4 U5 F1 F2 F3 F4 F5`
- Increase / Decrease buttons
- Program input: `1-99`
- Bank -> PC Delay: `0 / 5 / 10 ms`

## Behavior

- Bank selection resets Program to `1` and sends immediately.
- Program input keeps the current bank, clamps to `1-99`, and sends immediately.
- Increase/Decrease cross bank boundaries and wrap across the complete bank/program set.
- `F5 / 99 + 1 -> U1 / 1`, `U1 / 1 - 1 -> F5 / 99`.
- Delayed Program Change は常に最新の送信要求だけを保持する。
- Delay の変更だけでは Bank Select を再送しない。

## Architecture

- Parent device: `bank-program-changer_dev.amxd`
- Visible UI: `ui_as1.maxpat` via `bpatcher`
- Non-UI wiring: `logic_as1.maxpat` via `bpatcher`
- Controller: `bank_pc_controller_as1.js` via Max `[v8]`
- MIDI thru: `[midiin] -> [midiout]`
- UI actions and UI sync use separate `---ui-*-action` / `---ui-*` buses
- `bankIndex` and `pcDisplay` are the program-selection state

## Acceptance Criteria

- JavaScript tests cover program and bank boundaries and complete wrap.
- Generated messages use only `CC#32=0..9` and `PC=0..98` for selection.
- Saved Bank, Program, and Delay values restore correctly in Live.
- MIDI thru remains functional.
- AS-1 hardware selects representative programs in User and Factory banks.
