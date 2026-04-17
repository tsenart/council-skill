# Adapter Contract

Every harness adapter should implement the same user-facing behavior even if the host runtime differs.

## Required Capabilities

1. Resolve panel selection from:
   - explicit members
   - triad
   - profile
   - keyword defaulting
2. Run the three protocol rounds.
3. Preserve blind-first round 1 when possible.
4. Preserve cross-examination in round 2.
5. Produce the same final verdict shape.
6. Disclose when the adapter had to fall back to single-agent simulation.

## Recommended Capabilities

- parallel round 1 execution
- reusable subagent threads across rounds
- compact output by default
- optional transcript expansion

## Harness Notes

- Codex:
  - primary features: `spawn_agent`, `send_input`, `wait_agent`
  - fallback: single-agent simulation
- Claude:
  - package as a skill
  - optionally materialize reusable council-member agents
- Amp:
  - use its native orchestration if available
  - otherwise keep a single entrypoint and simulate the protocol

## Non-Goals

- locking the core to one model provider
- requiring one prompt format for every harness
- forcing one installation path across tools
