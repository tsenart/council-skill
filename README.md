# Council Skill

Portable multi-agent council skill for Codex, Claude Code, Amp, and any other
coding agent supported by the `skills` CLI.

Council is for questions where one answer is not enough: architecture choices,
strategy tradeoffs, debugging hypotheses, launch decisions, founder questions,
and risk reviews. The skill runs a compact three-round council protocol with
independent analysis, cross-exam, and a final verdict.

## Install

Install the skill from GitHub:

```bash
npx skills add <owner>/council-skill --skill council
```

Install it globally for specific agents:

```bash
npx skills add <owner>/council-skill --skill council -a codex -a claude-code -a amp -g -y
```

Install it from a local checkout while developing:

```bash
npx skills add . --skill council -a codex -a claude-code -a amp -y
```

## What Gets Installed

The installable skill lives at [skills/council/SKILL.md](skills/council/SKILL.md).
Its bundled references live under `skills/council/references/`.

Depending on the target agent, `skills` will install the skill into the
appropriate project or global skills directory. In practice this means:

- Codex: `.agents/skills/council/` or `~/.codex/skills/council/`
- Claude Code: `.claude/skills/council/` or `~/.claude/skills/council/`
- Amp: `.agents/skills/council/` or `~/.config/agents/skills/council/`

## Repository Layout

- `skills/council/` — the installable skill
- `examples/` — prompt ideas and a sample verdict
- `scripts/` — smoke validation for local and CI use

## Example Prompts

- Codex:
  `Use $council to stress test whether we should split the worker into a separate service.`
- Claude Code:
  `/council Should we keep one shared Postgres schema or split into product-specific schemas before launch?`
- Amp:
  `Use the council skill to deliberate on whether we should ship the narrow pilot now or wait for broader automation coverage.`

More examples live in [examples/prompt-library.md](examples/prompt-library.md)
and [examples/sample-verdict.md](examples/sample-verdict.md).

## Design Principles

- Keep the protocol harness-neutral.
- Prefer thin host-specific guidance inside one portable skill.
- Preserve blind-first round 1 whenever the host allows it.
- Do not force consensus.
- Favor compact verdicts over theatrical transcripts.

## Validation

Run the local smoke test:

```bash
bash scripts/smoke-test.sh
```

This checks that `npx skills add` discovers the skill and can install it into
Codex, Claude Code, and Amp target directories from a local checkout.
