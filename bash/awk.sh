#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# AWK basics / usage notes
# Run: bash bash/awk_basics.sh

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

cat > "$tmp" <<'EOF'
alpha 10 0.5
beta  3  2.0
gamma 7  1.25
delta 12 0.1
# comment line to ignore
EOF

printf "Input file: %s\n\n" "$tmp"
cat "$tmp"
printf "\n"

printf "1) Print whole lines (default action is {print \$0}):\n"
awk '{print}' "$tmp"
printf "\n"

printf "2) Skip comments / blank lines:\n"
awk 'NF && $1 !~ /^#/' "$tmp"
printf "\n"

printf "3) Fields: \$1 \$2 \$3 ...; NF=number of fields; \$0=whole line\n"
printf "   Print first + third columns:\n"
awk 'NF && $1 !~ /^#/ {print $1, $3}' "$tmp"
printf "\n"

printf "4) Change field separator (FS) and output separator (OFS):\n"
printf "   Example with colon-separated input:\n"
printf "a:1:2\nb:3:4\n" | awk -F: 'BEGIN{OFS=" | "} {print $1,$2,$3}'
printf "\n\n"

printf "5) BEGIN/END blocks (run once before/after processing):\n"
awk '
  BEGIN { sum=0; n=0; print "name value"; print "----------" }
  NF && $1 !~ /^#/ { sum += $2; n += 1; printf "%-5s %5d\n", $1, $2 }
  END   { printf "----------\ncount=%d sum=%d avg=%.2f\n", n, sum, (n?sum/n:0) }
' "$tmp"
printf "\n"

printf "6) Filters / conditions (only print rows where \$2 > 8):\n"
awk 'NF && $1 !~ /^#/ && $2 > 8 {print $1, $2}' "$tmp"
printf "\n"

printf "7) Arithmetic + formatting (printf):\n"
printf "   Compute \$2 * \$3 with 3 decimals:\n"
awk 'NF && $1 !~ /^#/ {printf "%-5s %.3f\n", $1, ($2 * $3)}' "$tmp"
printf "\n"

printf "8) Regex matching:\n"
printf "   Lines whose first field starts with g or d:\n"
awk '$1 ~ /^[gd]/ {print $0}' "$tmp"
printf "\n"

printf "9) Associative arrays (keyed counts):\n"
printf "   Count how many rows have \$2 <= 10 vs > 10:\n"
awk '
  NF && $1 !~ /^#/ {
    bucket = ($2 > 10) ? "gt10" : "le10"
    c[bucket]++
  }
  END {
    for (k in c) print k, c[k]
  }
' "$tmp"
printf "\n"

printf "10) Common pattern: \"last match\" (keep last seen value):\n"
printf "    Grab the last non-comment name in the file:\n"
awk 'NF && $1 !~ /^#/ {last=$1} END{print last}' "$tmp"
printf "\n"

printf "11) Using awk like a tiny CSV/TSV processor:\n"
printf "    (FS can be set to comma for CSV; real CSV quoting needs a real parser.)\n"
printf "x,y,z\n1,2,3\n" | awk -F, 'NR==1{print "header:", $0} NR>1{print $1+$2+$3}'
printf "\n\n"

printf "Done.\n"
