#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

required_repo_files=(
  "${ROOT_DIR}/skills/council/SKILL.md"
  "${ROOT_DIR}/skills/council/references/profiles.yaml"
  "${ROOT_DIR}/skills/council/references/protocol.md"
  "${ROOT_DIR}/skills/council/references/verdict-template.md"
  "${ROOT_DIR}/skills/council/references/personas/ada.md"
  "${ROOT_DIR}/skills/council/references/personas/socrates.md"
)

for file in "${required_repo_files[@]}"; do
  [[ -f "${file}" ]] || {
    echo "Missing required repo file: ${file}" >&2
    exit 1
  }
done

LIST_OUTPUT="$(
  cd "${TMP_DIR}" &&
    npx -y skills add "${ROOT_DIR}" --list
)"

echo "${LIST_OUTPUT}" | grep -q "council" || {
  echo "skills CLI did not discover the council skill." >&2
  exit 1
}

(
  cd "${TMP_DIR}" &&
    npx -y skills add "${ROOT_DIR}" \
      --skill council \
      --agent codex \
      --agent claude-code \
      --agent amp \
      --copy \
      -y
)

installed_files=(
  "${TMP_DIR}/.agents/skills/council/SKILL.md"
  "${TMP_DIR}/.agents/skills/council/references/profiles.yaml"
  "${TMP_DIR}/.agents/skills/council/references/protocol.md"
  "${TMP_DIR}/.claude/skills/council/SKILL.md"
  "${TMP_DIR}/.claude/skills/council/references/verdict-template.md"
)

for file in "${installed_files[@]}"; do
  [[ -f "${file}" ]] || {
    echo "Missing installed file: ${file}" >&2
    exit 1
  }
done

echo "Smoke test passed."
