"use strict";

this.inlets = 1;
this.outlets = 3;

const LIMITS = Object.freeze({
  bankIndexMin: 0,
  bankIndexMax: 9,
  pcMin: 1,
  pcMax: 99,
  clockModeMin: 0,
  clockModeMax: 1,
  validDelays: [0, 5, 10],
});

const BANK_LABELS = Object.freeze([
  "U1",
  "U2",
  "U3",
  "U4",
  "U5",
  "F1",
  "F2",
  "F3",
  "F4",
  "F5",
]);

const DEFAULT_STATE = Object.freeze({
  bankIndex: 0,
  pcDisplay: 1,
  delay: 0,
  clockMode: 0,
});
const MIDI_CONSTANTS = Object.freeze({
  ccStatus: 176,
  bankLsbController: 32,
  pcStatus: 192,
  nrpnMsbController: 99,
  nrpnLsbController: 98,
  dataEntryMsbController: 6,
  dataEntryLsbController: 38,
  midiClockModeNrpn: 1027,
});
const CLOCK_MODE_VALUES = Object.freeze([2, 4]);

const UI_SYNC_SELECTORS = Object.freeze([
  {
    selector: "set_bankindex",
    getValue(state) {
      return state.bankIndex;
    },
  },
  {
    selector: "set_pc",
    getValue(state) {
      return state.pcDisplay;
    },
  },
  {
    selector: "set_delay",
    getValue(state) {
      return state.delay;
    },
  },
  {
    selector: "set_clockmode",
    getValue(state) {
      return state.clockMode;
    },
  },
]);

function toNumber(value, fallback) {
  const number = Number(value);
  return Number.isFinite(number) ? number : fallback;
}

function toInt(value, fallback) {
  return Math.trunc(toNumber(value, fallback));
}

function clamp(value, min, max) {
  return Math.min(Math.max(value, min), max);
}

function buildStateViewFromSanitizedState(state) {
  return {
    state,
    derived: deriveProgramData(state.bankIndex, state.pcDisplay),
  };
}

function buildStateView(state) {
  return buildStateViewFromSanitizedState(sanitizeState(state));
}

function sanitizeDelay(value) {
  const delay = toInt(value, 0);
  return LIMITS.validDelays.includes(delay) ? delay : 0;
}

function sanitizeState(input) {
  const state = input || {};
  return {
    bankIndex: clamp(
      toInt(state.bankIndex, DEFAULT_STATE.bankIndex),
      LIMITS.bankIndexMin,
      LIMITS.bankIndexMax
    ),
    pcDisplay: clamp(
      toInt(state.pcDisplay, DEFAULT_STATE.pcDisplay),
      LIMITS.pcMin,
      LIMITS.pcMax
    ),
    delay: sanitizeDelay(state.delay),
    clockMode: clamp(
      toInt(state.clockMode, DEFAULT_STATE.clockMode),
      LIMITS.clockModeMin,
      LIMITS.clockModeMax
    ),
  };
}

function deriveProgramData(bankIndex, pcDisplay) {
  const safeState = sanitizeState({ bankIndex, pcDisplay });
  const pcIndex = safeState.pcDisplay - 1;

  return {
    bankIndex: safeState.bankIndex,
    bankDisplay: safeState.bankIndex + 1,
    bankLabel: BANK_LABELS[safeState.bankIndex],
    pcIndex,
    pcDisplay: safeState.pcDisplay,
    lsbSendValue: safeState.bankIndex,
    pcSendValue: pcIndex,
  };
}

function setBankIndex(state, bankIndex) {
  const safeState = sanitizeState(state);
  const nextBankIndex = clamp(
    toInt(bankIndex, safeState.bankIndex),
    LIMITS.bankIndexMin,
    LIMITS.bankIndexMax
  );

  return {
    ...safeState,
    bankIndex: nextBankIndex,
    pcDisplay: 1,
  };
}

function setPcDisplay(state, pcDisplay) {
  const safeState = sanitizeState(state);
  const nextPcDisplay = clamp(
    toInt(pcDisplay, safeState.pcDisplay),
    LIMITS.pcMin,
    LIMITS.pcMax
  );

  return {
    ...safeState,
    pcDisplay: nextPcDisplay,
  };
}

function stepProgram(state, step) {
  const safeState = sanitizeState(state);
  let bankIndex = safeState.bankIndex;
  let pcDisplay = safeState.pcDisplay + step;

  if (pcDisplay > LIMITS.pcMax) {
    pcDisplay = LIMITS.pcMin;
    bankIndex = bankIndex >= LIMITS.bankIndexMax
      ? LIMITS.bankIndexMin
      : bankIndex + 1;
  } else if (pcDisplay < LIMITS.pcMin) {
    pcDisplay = LIMITS.pcMax;
    bankIndex = bankIndex <= LIMITS.bankIndexMin
      ? LIMITS.bankIndexMax
      : bankIndex - 1;
  }

  return {
    ...safeState,
    bankIndex,
    pcDisplay,
  };
}

function incrementProgram(state) {
  return stepProgram(state, 1);
}

function decrementProgram(state) {
  return stepProgram(state, -1);
}

const ACTION_SPECS = Object.freeze({
  bankindex: {
    acceptsValue: true,
    shouldSend: true,
    reduce(state, value) {
      return setBankIndex(state, value);
    },
  },
  pc: {
    acceptsValue: true,
    shouldSend: true,
    reduce(state, value) {
      return setPcDisplay(state, value);
    },
  },
  inc: {
    acceptsValue: false,
    shouldSend: true,
    reduce(state) {
      return incrementProgram(state);
    },
  },
  dec: {
    acceptsValue: false,
    shouldSend: true,
    reduce(state) {
      return decrementProgram(state);
    },
  },
  delay: {
    acceptsValue: true,
    shouldSend: false,
    reduce(state, value) {
      return { ...state, delay: sanitizeDelay(value) };
    },
  },
  clockmode: {
    acceptsValue: true,
    shouldSend: false,
    shouldSendClockMode: true,
    reduce(state, value) {
      return {
        ...state,
        clockMode: clamp(
          toInt(value, state.clockMode),
          LIMITS.clockModeMin,
          LIMITS.clockModeMax
        ),
      };
    },
  },
  send: {
    acceptsValue: false,
    shouldSend: true,
    reduce(state) {
      return state;
    },
  },
  restorebegin: {
    acceptsValue: false,
    shouldSend: false,
    reduce(state) {
      return state;
    },
  },
  restoreend: {
    acceptsValue: false,
    shouldSend: false,
    reduce(state) {
      return state;
    },
  },
});

function reduceState(state, action) {
  const safeState = sanitizeState(state);
  const transition = ACTION_SPECS[action.type];

  if (!transition) {
    throw new Error(`Unknown action type: ${action.type}`);
  }

  return {
    state: transition.reduce(safeState, action.value),
    shouldSend: transition.shouldSend,
    shouldSendClockMode: transition.shouldSendClockMode === true,
  };
}

function buildNrpnMessages(parameterNumber, value) {
  const parameter = clamp(toInt(parameterNumber, 0), 0, 16383);
  const parameterValue = clamp(toInt(value, 0), 0, 16383);

  return [
    [MIDI_CONSTANTS.ccStatus, MIDI_CONSTANTS.nrpnMsbController, parameter >> 7],
    [MIDI_CONSTANTS.ccStatus, MIDI_CONSTANTS.nrpnLsbController, parameter & 0x7f],
    [MIDI_CONSTANTS.ccStatus, MIDI_CONSTANTS.dataEntryMsbController, parameterValue >> 7],
    [MIDI_CONSTANTS.ccStatus, MIDI_CONSTANTS.dataEntryLsbController, parameterValue & 0x7f],
  ];
}

function buildClockModeMessages(clockMode) {
  const index = clamp(
    toInt(clockMode, DEFAULT_STATE.clockMode),
    LIMITS.clockModeMin,
    LIMITS.clockModeMax
  );
  return buildNrpnMessages(MIDI_CONSTANTS.midiClockModeNrpn, CLOCK_MODE_VALUES[index]);
}

function buildMidiMessages(state) {
  const view = buildStateView(state);
  const bankMessages = [[MIDI_CONSTANTS.ccStatus, MIDI_CONSTANTS.bankLsbController, view.derived.lsbSendValue]];
  const pcMessage = [MIDI_CONSTANTS.pcStatus, view.derived.pcSendValue];

  return {
    state: view.state,
    derived: view.derived,
    bankMessages,
    pcMessage,
    allMessages: [...bankMessages, pcMessage],
  };
}

function buildSendPlan(state) {
  const midi = buildMidiMessages(state);

  if (midi.state.delay > 0) {
    return {
      delayMs: midi.state.delay,
      immediateMessages: midi.bankMessages,
      delayedMessages: [midi.pcMessage],
      midi,
    };
  }

  return {
    delayMs: 0,
    immediateMessages: midi.allMessages,
    delayedMessages: [],
    midi,
  };
}

function formatCurrentStatus(state) {
  const view = buildStateView(state);
  return `Current: ${view.derived.bankLabel} / PC ${view.derived.pcDisplay}`;
}

function formatSendStatus(state) {
  const view = buildStateView(state);
  return `Send: CC#32=${view.derived.lsbSendValue} / PC=${view.derived.pcSendValue}`;
}

function createNodeScheduler() {
  return {
    schedule(delayMs, fn) {
      return setTimeout(fn, delayMs);
    },
    cancel(handle) {
      clearTimeout(handle);
    },
  };
}

function createMaxScheduler(hostObject) {
  if (typeof Task === "function") {
    return {
      schedule(delayMs, fn) {
        const task = new Task(fn, hostObject || this);
        task.schedule(delayMs);
        return task;
      },
      cancel(handle) {
        if (handle && typeof handle.cancel === "function") {
          handle.cancel();
        }
      },
    };
  }

  return createNodeScheduler();
}

function applyNamedAction(controller, methodName, value) {
  const spec = ACTION_SPECS[methodName];
  const actionType = methodName;

  if (!spec) {
    throw new Error(`Unknown controller method: ${methodName}`);
  }

  return spec.acceptsValue
    ? controller.applyAction({ type: actionType, value })
    : controller.applyAction({ type: actionType });
}

function createController(runtime) {
  const env = runtime || {};
  const scheduler =
    env.scheduler ||
    (typeof outlet === "function" ? createMaxScheduler(env.hostObject || this) : createNodeScheduler());

  const controller = {
    state: sanitizeState(env.initialState || DEFAULT_STATE),
    pendingSend: null,
    isRestoring: false,
    restoreDirty: false,
    restoreClockModeDirty: false,
    runtime: {
      emitMidi: env.emitMidi || function noopMidi() {},
      emitUi: env.emitUi || function noopUi() {},
      emitStatus: env.emitStatus || function noopStatus() {},
      log: env.log || function noopLog() {},
      scheduler,
    },

    getState() {
      return { ...this.state };
    },

    getPendingSend() {
      if (!this.pendingSend) {
        return null;
      }

      return {
        delayMs: this.pendingSend.delayMs,
        messages: this.pendingSend.messages.map((message) => message.slice()),
      };
    },

    cancelPendingSend() {
      if (!this.pendingSend) {
        return;
      }

      this.runtime.scheduler.cancel(this.pendingSend.handle);
      this.pendingSend = null;
    },

    emitUiState() {
      const view = buildStateViewFromSanitizedState(this.state);

      for (const entry of UI_SYNC_SELECTORS) {
        this.runtime.emitUi(entry.selector, entry.getValue(view.state, view.derived));
      }
    },

    emitStatusLines() {
      this.runtime.emitStatus(formatCurrentStatus(this.state));
      this.runtime.emitStatus(formatSendStatus(this.state));
    },

    emitUiAndStatus() {
      this.emitUiState();
      this.emitStatusLines();
    },

    emitMessageList(messages) {
      for (const bytes of messages) {
        this.runtime.emitMidi(bytes.slice());
      }
    },

    scheduleDelayedMessages(messages, delayMs) {
      const clonedMessages = messages.map((message) => message.slice());
      const handle = this.runtime.scheduler.schedule(delayMs, () => {
        this.emitMessageList(clonedMessages);
        this.pendingSend = null;
      });

      this.pendingSend = {
        handle,
        delayMs,
        messages: clonedMessages,
      };
    },

    reconcilePendingDelayChange() {
      const plan = buildSendPlan(this.state);
      this.cancelPendingSend();

      if (plan.delayMs > 0) {
        this.scheduleDelayedMessages(plan.delayedMessages, plan.delayMs);
      } else {
        this.emitMessageList([plan.midi.pcMessage]);
      }

      this.emitStatusLines();
    },

    sendCurrentState() {
      const plan = buildSendPlan(this.state);
      this.cancelPendingSend();
      this.emitMessageList(plan.immediateMessages);

      if (plan.delayedMessages.length > 0) {
        this.scheduleDelayedMessages(plan.delayedMessages, plan.delayMs);
      }

      this.emitStatusLines();
    },

    sendClockMode() {
      this.emitMessageList(buildClockModeMessages(this.state.clockMode));
      this.emitStatusLines();
    },

    beginRestore() {
      this.cancelPendingSend();
      this.isRestoring = true;
      this.restoreDirty = false;
      this.restoreClockModeDirty = false;
      this.emitStatusLines();
    },

    endRestore() {
      const shouldFlush = this.isRestoring && this.restoreDirty;
      const shouldFlushClockMode = this.isRestoring && this.restoreClockModeDirty;
      this.isRestoring = false;
      this.restoreDirty = false;
      this.restoreClockModeDirty = false;
      this.emitUiState();

      if (shouldFlush) {
        this.sendCurrentState();
      }

      if (shouldFlushClockMode) {
        this.sendClockMode();
      } else if (!shouldFlush) {
        this.emitStatusLines();
      }
    },

    applyAction(action) {
      if (action.type === "restorebegin") {
        this.beginRestore();
        return this.getState();
      }

      if (action.type === "restoreend") {
        this.endRestore();
        return this.getState();
      }

      const hadPendingSend = this.pendingSend !== null;
      const previousState = this.state;
      const result = reduceState(previousState, action);

      // A normal bank edit resets Program to 1. During restore, Bank and Program
      // are independent saved parameters and may arrive in either order, so keep
      // the restored Program value until an explicit Program restore arrives.
      if (this.isRestoring && action.type === "bankindex") {
        result.state.pcDisplay = previousState.pcDisplay;
      }

      this.state = result.state;

      if (this.isRestoring) {
        if (result.shouldSend || action.type === "delay") {
          this.restoreDirty = true;
        }
        if (result.shouldSendClockMode) {
          this.restoreClockModeDirty = true;
        }

        this.cancelPendingSend();
        this.emitStatusLines();
      } else if (result.shouldSend) {
        this.emitUiState();
        this.sendCurrentState();
      } else if (result.shouldSendClockMode) {
        this.emitUiState();
        this.sendClockMode();
      } else if (action.type === "delay" && hadPendingSend) {
        this.emitUiState();
        this.reconcilePendingDelayChange();
      } else {
        this.emitUiState();
        this.emitStatusLines();
      }

      return this.getState();
    },

    loadbang() {
      this.emitUiAndStatus();
    },

    notifydeleted() {
      this.cancelPendingSend();
    },
  };

  for (const methodName of Object.keys(ACTION_SPECS)) {
    controller[methodName] = function controllerAction(value) {
      return applyNamedAction(this, methodName, value);
    };
  }

  return controller;
}

const isMaxEnvironment = typeof outlet === "function";

let maxController = null;

function createMaxRuntime(hostObject) {
  return {
    hostObject,
    emitMidi(bytes) {
      outlet(0, bytes);
    },
    emitUi(selector, value) {
      outlet(1, selector, value);
    },
    emitStatus(text) {
      outlet(2, text);
    },
    log(text) {
      if (typeof post === "function") {
        post(`${text}\n`);
      }
    },
  };
}

function createMaxController(hostObject) {
  return createController(createMaxRuntime(hostObject));
}

function getMaxController() {
  if (!maxController) {
    maxController = createMaxController(this);
  }

  return maxController;
}

function dispatchToMaxController(method, ...args) {
  if (!isMaxEnvironment) {
    return undefined;
  }

  return getMaxController.call(this)[method](...args);
}

function dispatchValueToMax(method, value) {
  return dispatchToMaxController.call(this, method, value);
}

function dispatchActionToMax(method) {
  return dispatchToMaxController.call(this, method);
}

function loadbang() {
  // In the device patch, restored live.* parameters are the source of truth.
  // Emitting the controller's default state on JS load can race with bpatcher restore
  // and overwrite the saved values before they are re-sent into the controller.
  return undefined;
}

function msg_int(value) {
  return dispatchValueToMax.call(this, "pc", value);
}

function msg_float(value) {
  return dispatchValueToMax.call(this, "pc", value);
}

function bang() {
  return dispatchActionToMax.call(this, "send");
}

function bankindex(value) {
  return dispatchValueToMax.call(this, "bankindex", value);
}

function pc(value) {
  return dispatchValueToMax.call(this, "pc", value);
}

function inc() {
  return dispatchActionToMax.call(this, "inc");
}

function dec() {
  return dispatchActionToMax.call(this, "dec");
}

function send() {
  return dispatchActionToMax.call(this, "send");
}

function wrap(value) {
  void value;
}

function delay(value) {
  return dispatchValueToMax.call(this, "delay", value);
}

function clockmode(value) {
  return dispatchValueToMax.call(this, "clockmode", value);
}

function restorebegin() {
  return dispatchActionToMax.call(this, "restorebegin");
}

function restoreend() {
  return dispatchActionToMax.call(this, "restoreend");
}

function notifydeleted() {
  return dispatchActionToMax.call(this, "notifydeleted");
}

function anything(...args) {
  if (isMaxEnvironment && typeof post === "function") {
    post(`bank_pc_controller_as1.js: unknown message "${this.messagename}" ${args.join(" ")}\n`);
  }
}

const exported = {
  LIMITS,
  BANK_LABELS,
  DEFAULT_STATE,
  sanitizeState,
  deriveProgramData,
  buildStateView,
  setBankIndex,
  setPcDisplay,
  incrementProgram,
  decrementProgram,
  reduceState,
  buildMidiMessages,
  buildNrpnMessages,
  buildClockModeMessages,
  buildSendPlan,
  formatCurrentStatus,
  formatSendStatus,
  applyNamedAction,
  createController,
  createMaxRuntime,
  createMaxController,
};

if (typeof module !== "undefined" && module.exports) {
  module.exports = exported;
}
