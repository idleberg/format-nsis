#!/usr/bin/env bash
set -euo pipefail

files=("$@")
nsis_files=()

for file in "${files[@]}"; do
  case "$file" in
    *.nsi|*.nsh)
      if [ -f "$file" ]; then
        nsis_files+=("$file")
      fi
      ;;
  esac
done

if [ ${#nsis_files[@]} -eq 0 ]; then
  echo "No NSIS files found in changed files."
  exit 0
fi

args=()

if [ -n "${ARDENT_EOL:-}" ]; then
  args+=(--eol "$ARDENT_EOL")
fi

if [ -n "${ARDENT_INDENT_SIZE:-}" ]; then
  args+=(--indent-size "$ARDENT_INDENT_SIZE")
fi

if [ "${ARDENT_USE_SPACES:-false}" = "true" ]; then
  args+=(--use-spaces)
fi

if [ "${ARDENT_NO_TRIM:-false}" = "true" ]; then
  args+=(--no-trim)
fi

if [ -n "${ARDENT_PRINT_WIDTH:-}" ]; then
  args+=(--print-width "$ARDENT_PRINT_WIDTH")
fi

if [ "${ARDENT_CHECK_ONLY:-false}" = "true" ]; then
  ardent check "${args[@]}" "${nsis_files[@]}"
else
  ardent format --write "${args[@]}" "${nsis_files[@]}"
fi
