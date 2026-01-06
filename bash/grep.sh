#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# GREP basics / usage notes
# Run: bash bash/grep_basics.sh

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

cat > "$tmp" <<'EOF'
INFO 2026-01-06 startup complete
WARN 2026-01-06 disk usage 67%
ERROR 2026-01-06 failed to open file: config.yaml
INFO 2026-01-06 user=nick action=login
DEBUG 2026-01-06 retry=1
ERROR 2026-01-06 timeout after 3.50s
EOF

printf "Input file: (temporary demo log)\n\n"
cat "$tmp"
printf "\n"

printf "1) Basic search (lines containing 'ERROR'):\n"
grep 'ERROR' "$tmp"
printf "\n"

printf "2) Case-insensitive (-i):\n"
grep -i 'error' "$tmp"
printf "\n"

printf "3) Invert match (-v) (everything except DEBUG):\n"
grep -v 'DEBUG' "$tmp"
printf "\n"

printf "4) Show line numbers (-n):\n"
grep -n 'ERROR' "$tmp"
printf "\n"

printf "5) Count matches (-c):\n"
grep -c 'ERROR' "$tmp"
printf "\n"

printf "6) Whole-word (-w) (word boundaries):\n"
printf "   (matches 'WARN' but not 'WARNING')\n"
printf "WARN\nWARNING\n" | grep -w 'WARN'
printf "\n"

printf "7) Match whole line (-x):\n"
printf "WARN\nWARNING\n" | grep -x 'WARN'
printf "\n"

printf "8) Extended regex (-E):\n"
printf "   Match INFO or WARN:\n"
grep -E '^(INFO|WARN) ' "$tmp"
printf "\n"

printf "9) Basic regex (default grep) vs -E:\n"
printf "   With basic grep, + and | are not special unless escaped.\n"
printf "   Prefer -E for anything beyond simple patterns.\n\n"

printf "10) Show context around matches (-C, -A, -B):\n"
printf "    1 line before and after ERROR:\n"
grep -n -C 1 'ERROR' "$tmp"
printf "\n"

printf "11) Only print the matching part (-o):\n"
printf "    Extract the date (YYYY-MM-DD):\n"
grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$tmp" | head -n 3
printf "\n"

printf "12) Quiet mode (-q) for conditionals:\n"
if grep -q 'timeout' "$tmp"; then
  printf "Found 'timeout' (exit code 0)\n"
else
  printf "Did not find 'timeout'\n"
fi
printf "\n"

printf "13) Recursive search (-r) + file filters (--include/--exclude):\n"
printf "    Examples (not run here):\n"
printf "      grep -R \"pattern\" .\n"
printf "      grep -R --include='*.log' \"ERROR\" .\n"
printf "      grep -R --exclude-dir='.git' \"TODO\" .\n\n"

printf "14) Fixed-string mode (-F) (no regex; faster/safer for literals):\n"
printf "    Search for a literal '[abc]' string:\n"
printf "literal [abc]\nregex abc\n" | grep -F '[abc]'
printf "\n"

printf "15) Common pitfalls / tips:\n"
printf "    - Quote patterns to avoid shell glob expansion.\n"
printf "    - Use -F for literal strings (paths, JSON fragments, etc.).\n"
printf "    - Use -E for alternation, +, ?, and groups.\n"
printf "    - Remember grep is line-based.\n\n"

printf "Done.\n"
