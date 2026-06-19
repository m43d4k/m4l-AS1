# TORAIZ AS-1 MIDI Reference

デバイスが使用するAS-1のMIDI仕様と実機確認項目をまとめる。

## Confirmed From The Operating Instructions

- 10 banks: Factory `F1-F5` and User `U1-U5`
- 99 programs per bank
- User banks are rewritable; Factory banks are read-only
- Program Change receive range: `0-98` for displayed programs `1-99`
- Bank Select uses `CC#32`
- Transmitted Bank Select range: `0-9` for banks `1-10`
- MIDI Channel setting: `All` or `1-16`

## Bank Value Mapping Used By This Project

| CC#32 | Bank |
|---:|---|
| 0-4 | U1-U5 |
| 5-9 | F1-F5 |

このマッピングはAS-1実機でU5/F1境界を含めて確認済み。

## Manual Ambiguity

英語版取扱説明書の Received Controller Messages には、Bank Select が
`0-5: user banks 1-5; 6-10: factory banks 1-5` と記載されている。この範囲は
10バンクに対して11値を含み、同じ取説の transmitted range `0-9` とも整合しない。

本デバイスでは、10個の0-based bank valuesとして`0-4=U1-U5`,
`5-9=F1-F5`を使用する。

## Primary Reference

- [Pioneer DJ: TORAIZ AS-1 manuals and documentation](https://www.pioneerdj.com/en/support/documents/production/toraiz-as-1/)
  (retrieved 2026-06-19)
- *TORAIZ AS-1 Operating Instructions*, sections:
  - Choosing and playing a program
  - GLOBAL SETTING / MIDI Channel
  - MIDI Implementation / Received Channel Messages
  - MIDI Implementation / Received Controller Messages
  - MIDI Implementation / Transmitted Controller Messages

Product manuals can move between Pioneer DJ and AlphaTheta support domains. If a local copy is
kept later, record its language, revision, download URL, and retrieval date here.

## Hardware Verification

以下の項目をAS-1実機で確認済み。リリース前の回帰確認にも使用する。

- Set AS-1 `MIDI Control Enable` so external program selection is accepted.
- Match the Live output channel and AS-1 `MIDI Channel`.
- Verify `CC#32=0 + PC=0` selects `U1 P1`.
- Verify `CC#32=4 + PC=98` selects `U5 P99`.
- Verify `CC#32=5 + PC=0` selects `F1 P1`.
- Verify `CC#32=9 + PC=98` selects `F5 P99`.
- Test Bank -> PC delay at `0`, `5`, and `10 ms`.
- Confirm incoming performance MIDI still passes through while selecting programs.
