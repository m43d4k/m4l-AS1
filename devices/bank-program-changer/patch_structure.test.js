"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const DEVICE_DIR = __dirname;

function readJson(filename) {
  return JSON.parse(fs.readFileSync(path.join(DEVICE_DIR, filename), "utf8"));
}

function readAmxdPatch(filename) {
  const amxd = fs.readFileSync(path.join(DEVICE_DIR, filename));

  assert.equal(amxd.subarray(0, 4).toString("ascii"), "ampf");
  assert.equal(amxd.subarray(24, 28).toString("ascii"), "ptch");

  const patchSize = amxd.readUInt32LE(28);
  const patchData = amxd.subarray(32);
  assert.equal(patchSize, patchData.length, "ptch chunk size must reach EOF");

  const nulOffset = patchData.indexOf(0);
  assert.notEqual(nulOffset, -1, "ptch JSON must be NUL-terminated");
  assert.equal(
    patchData.subarray(nulOffset + 1).toString("ascii"),
    "\n",
    "only the final newline may follow the NUL terminator"
  );

  return JSON.parse(patchData.subarray(0, nulOffset).toString("utf8"));
}

function getBoxesById(patch) {
  const map = new Map();

  for (const entry of patch.patcher.boxes) {
    map.set(entry.box.id, entry.box);
  }

  return map;
}

function hasLine(patch, sourceId, destinationId) {
  return patch.patcher.lines.some((entry) => {
    const line = entry.patchline;
    return line.source[0] === sourceId && line.destination[0] === destinationId;
  });
}

test("logic patch keeps controller, MIDI thru, and UI sync wiring", () => {
  const patch = readJson("logic_as1.maxpat");
  const boxes = getBoxesById(patch);

  assert.equal(boxes.get("obj-v8").text, "v8 bank_pc_controller_as1.js");
  assert.equal(boxes.get("obj-midiin").text, "midiin");
  assert.equal(boxes.get("obj-midiout").text, "midiout");
  assert.equal(
    boxes.get("obj-route-ui").text,
    "route set_bankindex set_pc set_delay set_clockmode"
  );

  assert.ok(hasLine(patch, "obj-midiin", "obj-midiout"));
  assert.ok(hasLine(patch, "obj-v8", "obj-midiout"));
  assert.ok(hasLine(patch, "obj-v8", "obj-route-ui"));
  assert.ok(hasLine(patch, "obj-v8", "obj-route-status"));
  assert.equal(boxes.get("obj-recv-restore").text, "r ---ui-restore-action");
  assert.ok(hasLine(patch, "obj-recv-restore", "obj-v8"));
  assert.equal(boxes.get("obj-recv-clockmode").text, "r ---ui-clockmode-action");
  assert.equal(boxes.get("obj-prepend-clockmode").text, "prepend clockmode");
  assert.ok(hasLine(patch, "obj-recv-clockmode", "obj-prepend-clockmode"));
  assert.ok(hasLine(patch, "obj-prepend-clockmode", "obj-v8"));
  assert.ok(hasLine(patch, "obj-route-ui", "obj-send-clockmode-ui"));
});

test("ui patch restores bank, program, delay, and MIDI clock mode", () => {
  const patch = readJson("ui_as1.maxpat");
  const boxes = getBoxesById(patch);

  assert.equal(boxes.get("obj-4").text, "r ---parent-restore-trigger");
  assert.equal(boxes.get("obj-delay-init").text, "outputvalue");
  assert.equal(boxes.get("obj-restore-delay").text, "delay 50");
  assert.equal(boxes.get("obj-restore-delay-late").text, "delay 200");
  assert.equal(boxes.get("obj-restore-begin-msg").text, "restorebegin");
  assert.equal(boxes.get("obj-restore-end").text, "delay 260");
  assert.equal(boxes.get("obj-restore-end-msg").text, "restoreend");
  assert.equal(boxes.get("obj-send-restore").text, "s ---ui-restore-action");

  assert.ok(hasLine(patch, "obj-4", "obj-restore-begin-msg"));
  assert.ok(hasLine(patch, "obj-4", "obj-restore-delay"));
  assert.ok(hasLine(patch, "obj-4", "obj-restore-end"));
  assert.ok(hasLine(patch, "obj-4", "obj-restore-delay-late"));
  assert.ok(hasLine(patch, "obj-restore-begin-msg", "obj-send-restore"));
  assert.ok(hasLine(patch, "obj-restore-delay", "obj-delay-init"));
  assert.ok(hasLine(patch, "obj-restore-end", "obj-restore-end-msg"));
  assert.ok(hasLine(patch, "obj-restore-end-msg", "obj-send-restore"));
  assert.ok(hasLine(patch, "obj-restore-delay-late", "obj-delay-init"));
  assert.ok(hasLine(patch, "obj-delay-init", "obj-delay"));
  assert.ok(hasLine(patch, "obj-delay-init", "obj-bank"));
  assert.ok(hasLine(patch, "obj-delay-init", "obj-pc"));
  assert.ok(hasLine(patch, "obj-delay-init", "obj-clockmode"));
});

test("ui patch exposes the ten AS-1 banks, increment, and decrement for Live mapping", () => {
  const patch = readJson("ui_as1.maxpat");
  const boxes = getBoxesById(patch);
  const bankParameter = boxes.get("obj-bank").saved_attribute_attributes.valueof;
  const programParameter = boxes.get("obj-pc").saved_attribute_attributes.valueof;
  const clockMode = boxes.get("obj-clockmode");
  const clockParameter = clockMode.saved_attribute_attributes.valueof;

  assert.equal(boxes.get("obj-bank").parameter_enable, 1);
  assert.equal(boxes.get("obj-bank").num_lines_presentation, 10);
  assert.deepEqual(bankParameter.parameter_enum, [
    "U1", "U2", "U3", "U4", "U5", "F1", "F2", "F3", "F4", "F5",
  ]);
  assert.equal(bankParameter.parameter_mmax, 9);
  assert.equal(bankParameter.parameter_invisible ?? 0, 0);
  assert.equal(boxes.get("obj-pc").maxclass, "live.numbox");
  assert.equal(boxes.get("obj-pc").parameter_enable, 1);
  assert.equal(programParameter.parameter_mmin, 1);
  assert.equal(programParameter.parameter_mmax, 99);
  assert.equal(programParameter.parameter_invisible ?? 0, 0);
  assert.equal(programParameter.parameter_initial_enable, undefined);
  assert.equal(programParameter.parameter_initial, undefined);
  assert.equal(boxes.has("obj-global-display"), false);
  assert.equal(boxes.get("obj-1").parameter_enable, 1);
  assert.equal(boxes.get("obj-1").saved_attribute_attributes.valueof.parameter_invisible ?? 0, 0);
  assert.equal(boxes.get("obj-2").parameter_enable, 1);
  assert.equal(boxes.get("obj-2").saved_attribute_attributes.valueof.parameter_invisible ?? 0, 0);
  assert.equal(clockMode.maxclass, "live.text");
  assert.equal(clockMode.mode, 1);
  assert.equal(clockMode.parameter_enable, 1);
  assert.equal(boxes.get("obj-clockmode-label").text, "SEQ");
  assert.equal(clockMode.text, "SYNC");
  assert.equal(clockMode.texton, "MANUAL");
  assert.deepEqual(clockParameter.parameter_enum, ["SYNC", "MANUAL"]);
  assert.equal(clockParameter.parameter_mmax, 1);
  assert.ok(hasLine(patch, "obj-clockmode", "obj-send-clockmode"));
  assert.ok(hasLine(patch, "obj-recv-clockmode", "obj-set-clockmode"));
  assert.ok(hasLine(patch, "obj-set-clockmode", "obj-clockmode"));
});

test("parent device still references child patchers and restore trigger pieces", () => {
  const amxdPatch = readAmxdPatch("bank-program-changer_dev.amxd");
  const amxdText = JSON.stringify(amxdPatch);

  for (const pattern of [
    /"text"\s*:\s*"loadbang"/,
    /"text"\s*:\s*"live\.thisdevice"/,
    /"text"\s*:\s*"s ---parent-restore-trigger"/,
    /"name"\s*:\s*"ui_as1\.maxpat"/,
    /"name"\s*:\s*"logic_as1\.maxpat"/,
    /"name"\s*:\s*"bank_pc_controller_as1\.js"/,
  ]) {
    assert.match(amxdText, pattern);
  }
});
