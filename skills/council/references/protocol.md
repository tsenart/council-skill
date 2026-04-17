# Council Protocol

This protocol is harness-agnostic. Adapters should map it onto the local orchestration features of the host environment.

## Inputs

- problem statement
- optional profile
- optional triad
- optional explicit member list
- optional `show_rounds` flag

## Panel Selection

1. If the user specifies `--members`, use exactly those members.
2. Else if the user specifies `--triad`, resolve that triad inside the chosen profile.
3. Else if the user specifies `--profile`, use that profile's default triad.
4. Else inspect the problem statement for a known keyword triad.
5. Else use `classic` + `architecture`.

Default behavior should prefer 3 members for speed and clarity. Use the full panel only when the user asks for it or when the decision is unusually ambiguous.

## Round 1: Independent Analysis

- Run each selected member independently.
- Keep the first round blind-first: each member sees the problem statement and their own persona only.
- Ask for a compact standalone analysis with a clear verdict and confidence level.
- Prefer parallel execution when the harness supports it.

## Round 2: Cross-Examination

- Share the round 1 outputs with each member.
- Ask each member to:
  - name the position they most disagree with and why
  - name one insight that strengthened their thinking
  - say whether anything changed
  - restate their position after the exchange
- Prefer sequential execution so later responses can react to earlier cross-exams.

## Round 3: Final Position

- Ask for a short final stance only.
- No new arguments unless a harness limitation forces a condensed fallback.
- Socrates may ask one final question before stating a position.

## Synthesis

Use the verdict template and report:

- problem
- composition
- consensus or lack of consensus
- points of agreement
- points of disagreement
- minority report
- unresolved questions
- recommended next steps

Keep the default output compact. Only include round transcripts when the user asks for them.

## Enforcement Rules

- Do not allow recursive questioning loops.
- Require real disagreement before declaring consensus.
- If consensus arrives too early, run one counterfactual pass:
  - Assume the current consensus is wrong. What strongest alternative would flip the decision?
- If the harness cannot support multi-round orchestration, simulate the same structure in one agent and disclose that fallback.

## Graceful Fallback

When a harness cannot spawn subagents or parallelize:

1. simulate round 1 as clearly separated persona sections
2. simulate round 2 as explicit disagreements between those sections
3. simulate round 3 as short final positions
4. synthesize the verdict in the same format
