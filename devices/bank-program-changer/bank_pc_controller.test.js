"use strict";

const test = require("node:test");
const assert = require("node:assert/strict");

const {
  DEFAULT_STATE,
  applyNamedAction,
  buildMidiMessages,
  buildSendPlan,
  buildStateView,
  createController,
  createMaxController,
  deriveProgramData,
  formatCurrentStatus,
  formatSendStatus,
  reduceState,
  sanitizeState,
} = require("./bank_pc_controller_as1.js");

class FakeScheduler {
  constructor() {
    this.handles = [];
    this.nextId = 1;
  }

  schedule(delayMs, fn) {
    const handle = {
      id: this.nextId++, delayMs, fn, cancelled: false, fired: false,
    };
    this.handles.push(handle);
    return handle;
  }

  cancel(handle) {
    if (handle) handle.cancelled = true;
  }

  flushAll() {
    for (const handle of this.handles) {
      if (!handle.cancelled && !handle.fired) {
        handle.fired = true;
        handle.fn();
      }
    }
  }
}

function createRuntime(initialState) {
  const scheduler = new FakeScheduler();
  const midi = [];
  const ui = [];
  const status = [];
  const controller = createController({
    initialState,
    scheduler,
    emitMidi(bytes) { midi.push(bytes); },
    emitUi(selector, value) { ui.push([selector, value]); },
    emitStatus(text) { status.push(text); },
  });
  return { controller, scheduler, midi, ui, status };
}

test("deriveProgramData maps bank and displayed program directly", () => {
  assert.deepEqual(deriveProgramData(5, 99), {
    bankIndex: 5,
    bankDisplay: 6,
    bankLabel: "F1",
    pcIndex: 98,
    pcDisplay: 99,
    lsbSendValue: 5,
    pcSendValue: 98,
  });
});

test("sanitizeState clamps bank/program and normalizes delay", () => {
  assert.deepEqual(sanitizeState({ bankIndex: 20, pcDisplay: 0, delay: 7 }), {
    bankIndex: 9,
    pcDisplay: 1,
    delay: 0,
  });
});

test("buildStateView combines sanitized state and MIDI values", () => {
  assert.deepEqual(buildStateView({ bankIndex: 2, pcDisplay: 44, delay: 10 }), {
    state: { bankIndex: 2, pcDisplay: 44, delay: 10 },
    derived: deriveProgramData(2, 44),
  });
});

test("reduceState handles bank reset, program clamp, boundaries, and full wrap", () => {
  for (let bankIndex = 0; bankIndex < 9; bankIndex += 1) {
    let boundary = reduceState({ bankIndex, pcDisplay: 99 }, { type: "inc" });
    assert.deepEqual(boundary.state, { bankIndex: bankIndex + 1, pcDisplay: 1, delay: 0 });

    boundary = reduceState(boundary.state, { type: "dec" });
    assert.deepEqual(boundary.state, { bankIndex, pcDisplay: 99, delay: 0 });
  }

  let result = reduceState({ bankIndex: 9, pcDisplay: 99 }, { type: "inc" });
  assert.deepEqual(result.state, DEFAULT_STATE);

  result = reduceState(DEFAULT_STATE, { type: "dec" });
  assert.deepEqual(result.state, { bankIndex: 9, pcDisplay: 99, delay: 0 });

  result = reduceState({ bankIndex: 2, pcDisplay: 44 }, { type: "bankindex", value: 5 });
  assert.deepEqual(result.state, { bankIndex: 5, pcDisplay: 1, delay: 0 });

  result = reduceState(result.state, { type: "pc", value: 100 });
  assert.equal(result.state.pcDisplay, 99);
  assert.throws(() => reduceState(DEFAULT_STATE, { type: "global", value: 1 }), /Unknown action type/);
});

test("MIDI and delayed-send plans use bank/program state", () => {
  const state = { bankIndex: 2, pcDisplay: 44, delay: 10 };
  assert.deepEqual(buildMidiMessages(state).allMessages, [
    [176, 32, 2],
    [192, 43],
  ]);
  const plan = buildSendPlan(state);
  assert.deepEqual(plan.immediateMessages, [[176, 32, 2]]);
  assert.deepEqual(plan.delayedMessages, [[192, 43]]);
  assert.equal(plan.delayMs, 10);
});

test("controller sync contains only bank, program, and delay", () => {
  const { controller, ui, status } = createRuntime({ bankIndex: 2, pcDisplay: 44, delay: 10 });
  controller.loadbang();
  assert.deepEqual(ui, [
    ["set_bankindex", 2],
    ["set_pc", 44],
    ["set_delay", 10],
  ]);
  assert.deepEqual(status, [
    formatCurrentStatus(controller.getState()),
    formatSendStatus(controller.getState()),
  ]);
});

test("createMaxController routes MIDI, UI, and status to Max outlets", () => {
  const outletCalls = [];
  const originalOutlet = global.outlet;
  const originalPost = global.post;
  global.outlet = (...args) => outletCalls.push(args);
  global.post = () => {};

  try {
    const controller = createMaxController({});
    controller.loadbang();
    controller.send();
    assert.deepEqual(outletCalls.slice(0, 3), [
      [1, "set_bankindex", 0],
      [1, "set_pc", 1],
      [1, "set_delay", 0],
    ]);
    assert.deepEqual(outletCalls.slice(-4), [
      [0, [176, 32, 0]],
      [0, [192, 0]],
      [2, "Current: U1 / PC 1"],
      [2, "Send: CC#32=0 / PC=0"],
    ]);
  } finally {
    global.outlet = originalOutlet;
    global.post = originalPost;
  }
});

test("bank, program, increment, and decrement update state and emit MIDI", () => {
  const { controller, midi } = createRuntime(DEFAULT_STATE);
  controller.bankindex(1);
  controller.pc(42);
  controller.inc();
  controller.dec();
  assert.deepEqual(controller.getState(), { bankIndex: 1, pcDisplay: 42, delay: 0 });
  assert.deepEqual(midi.slice(-2), [[176, 32, 1], [192, 41]]);
});

test("applyNamedAction no longer exposes a global action", () => {
  const { controller } = createRuntime(DEFAULT_STATE);
  applyNamedAction(controller, "pc", 44);
  assert.equal(controller.getState().pcDisplay, 44);
  assert.throws(() => applyNamedAction(controller, "global", 44), /Unknown controller method/);
});

test("a state change replaces a pending delayed program snapshot", () => {
  const { controller, scheduler, midi } = createRuntime({ bankIndex: 0, pcDisplay: 1, delay: 10 });
  controller.send();
  controller.bankindex(2);
  controller.pc(44);
  assert.deepEqual(midi, [[176, 32, 0], [176, 32, 2], [176, 32, 2]]);
  scheduler.flushAll();
  assert.deepEqual(midi.at(-1), [192, 43]);
});

test("delay change reschedules a pending program without resending bank select", () => {
  const { controller, scheduler, midi } = createRuntime({ bankIndex: 2, pcDisplay: 44, delay: 10 });
  controller.send();
  controller.delay(5);
  assert.deepEqual(midi, [[176, 32, 2]]);
  assert.deepEqual(controller.getPendingSend(), { delayMs: 5, messages: [[192, 43]] });
  scheduler.flushAll();
  assert.deepEqual(midi.at(-1), [192, 43]);
});

test("restore coalesces restored bank, program, and delay into one send", () => {
  const { controller, scheduler, midi, ui } = createRuntime(DEFAULT_STATE);
  controller.restorebegin();
  controller.bankindex(5);
  controller.pc(44);
  controller.delay(10);
  assert.deepEqual(midi, []);
  assert.deepEqual(ui, []);
  controller.restoreend();
  assert.deepEqual(controller.getState(), { bankIndex: 5, pcDisplay: 44, delay: 10 });
  assert.deepEqual(ui, [
    ["set_bankindex", 5],
    ["set_pc", 44],
    ["set_delay", 10],
  ]);
  assert.deepEqual(midi, [[176, 32, 5]]);
  scheduler.flushAll();
  assert.deepEqual(midi.at(-1), [192, 43]);
});

test("restore does not let bank reset or UI sync overwrite a saved program", () => {
  const { controller, ui } = createRuntime({ bankIndex: 0, pcDisplay: 73, delay: 0 });
  controller.restorebegin();
  controller.bankindex(5);

  assert.deepEqual(controller.getState(), { bankIndex: 5, pcDisplay: 73, delay: 0 });
  assert.deepEqual(ui, []);

  controller.restoreend();
  assert.deepEqual(ui, [
    ["set_bankindex", 5],
    ["set_pc", 73],
    ["set_delay", 0],
  ]);
});

test("notifydeleted cancels pending delayed output", () => {
  const { controller, scheduler, midi } = createRuntime({ bankIndex: 2, pcDisplay: 44, delay: 10 });
  controller.send();
  controller.notifydeleted();
  scheduler.flushAll();
  assert.deepEqual(midi, [[176, 32, 2]]);
});
