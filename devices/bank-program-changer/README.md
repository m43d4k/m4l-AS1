# bank-program-changer

TORAIZ AS-1 に Bank Select LSB と Program Change を送信する Max for Live
MIDI Effect。

## Features

- Bank `live.tab`: `U1-U5`, `F1-F5` の10バンク
- Program: `P1-P99`
- Bank Select: `CC#32`, value `0-9`
- Program Change: value `0-98`
- SEQ Play: `SYNC / MANUAL`（NRPN `1027`, value `2 / 4`）
- Bank SelectとProgram Changeの間隔: `0 / 5 / 10 ms`
- MIDI thru
- Live SetでのBank、Program、Delay、MIDI Clock Modeの保存・復元

## Documents

- [`SPEC.md`](SPEC.md) - デバイス仕様
- [`AS1_MIDI_REFERENCE.md`](AS1_MIDI_REFERENCE.md) - MIDI仕様の根拠と実機確認項目
- [`patching-notes.md`](patching-notes.md) - 現行パッチの配線・復元仕様
- [`AGENTS.md`](AGENTS.md) - このディレクトリを変更する際の実装ルール

## Current Files

- `bank_pc_controller_as1.js` - Max v8 controller
- `bank_pc_controller.test.js` - JavaScript tests
- `ui_as1.maxpat` - visible child UI patch
- `logic_as1.maxpat` - non-UI child patch
- `bank-program-changer_dev.amxd` - Live で読み込む親デバイス

## Tests

```sh
mise exec node@22 -- node --test *.test.js
```

テストはBank境界、MIDI bytes、状態復元用のパッチ構造を検証する。
リリース前にはMax/Live上の動作とAS-1実機への送信も確認する。
