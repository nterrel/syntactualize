#!/usr/bin/env bash
#
# Bash basics / syntax notes
# Run: bash ~/syntactualize/bash/basics.sh
# Make executable: chmod +x ~/syntactualize/bash/basics.sh
#

# --- "strict-ish" mode (recommended for scripts) ---
# -e  : exit on error (non-zero status)
# -u  : error on unset variables
# -o pipefail : pipeline fails if any command fails
set -euo pipefail
IFS=$'\n\t'

# Comments are with '#'
printf "Hi there!\n"
printf "Bash separates commands by newlines or semicolons.\n\n"

# --- Variables ---
# Don't put spaces around '='. 
# Variables are untyped strings by default.
count=5
name="Nick"

printf "count=%s, name=%s\n" "$count" "$name"

# Use braces when concatenating with text to avoid ambiguity:
file="data"
printf "Example: %s\n" "${file}_001.txt"

# "Unset variable" safety:
# With 'set -u', referencing an unset var is an error, so use defaults:
maybe_unset="${MAYBE_UNSET:-default_value}"
printf "MAYBE_UNSET (defaulted) = %s\n\n" "$maybe_unset"

# --- Quoting rules (VERY IMPORTANT) ---
# "double quotes" expand variables, command substitutions, and backslashes like \n in $'...' only.
# 'single quotes' are literal (no expansion).
# unquoted variables undergo word splitting + glob expansion (often a bug).

path_with_spaces="/tmp/my folder"
printf "Double quotes expand: name=%s\n" "$name"
printf 'Single quotes are literal: $name stays $name\n'

# printf is usually safer than echo for portability and escapes
printf "Always quote: '%s'\n\n" "$path_with_spaces"

# --- Command substitution ---
# Prefer $(...) over backticks
today="$(date +%Y-%m-%d)"
printf "Today is %s\n\n" "$today"

# --- Arrays (indexed) ---
arr=("One" "Two words" "Three")
printf "arr[0]=%s\n" "${arr[0]}"
printf "All elements (quoted) -> preserves spaces:\n"
for x in "${arr[@]}"; do
  printf "  - %s\n" "$x"
done
printf "\n"

# Array length
printf "Array length: %s\n\n" "${#arr[@]}"

# --- Associative arrays (bash 4+) ---
# Great for dictionary-like use. (macOS ships bash 3.2 by default, no -A support.)
if (( BASH_VERSINFO[0] >= 4 )); then
  declare -A dict
  dict["One"]=1
  dict["Two"]=2
  dict["Three"]=3

  printf "dict[One]=%s\n" "${dict[One]}"
  printf "Keys (unordered):\n"
  for k in "${!dict[@]}"; do
    printf "  %s => %s\n" "$k" "${dict[$k]}"
  done
else
  printf "Associative arrays require Bash 4+. You are running Bash %s.%s.\n" \
    "${BASH_VERSINFO[0]}" "${BASH_VERSINFO[1]}"

  # Simple fallback “dict” via parallel arrays
  dict_keys=("One" "Two" "Three")
  dict_vals=(1 2 3)

  printf "Fallback dict example:\n"
  for idx in "${!dict_keys[@]}"; do
    printf "  %s => %s\n" "${dict_keys[$idx]}" "${dict_vals[$idx]}"
  done
fi
printf "\n"

# --- Arithmetic ---
# Use (( ... )) for arithmetic context
a=7
b=3
sum=$((a + b))
printf "%s + %s = %s\n\n" "$a" "$b" "$sum"

# --- Conditionals / tests ---
# Use [[ ... ]] (Bash test) rather than [ ... ] for fewer footguns.
n=10
if [[ $n -gt 5 ]]; then
  printf "%s is greater than 5\n" "$n"
fi

s="hello"
if [[ $s == h* ]]; then
  printf "'%s' matches glob h*\n" "$s"
fi
printf "\n"

# File tests: -e exists, -f regular file, -d directory
some_path="bash"
if [[ -d $some_path ]]; then
  printf "%s is a directory\n\n" "$some_path"
fi

# --- Loops ---
# C-style loop
for ((i=1; i<=5; i++)); do
  printf "i is currently: %s\n" "$i"
done
printf "\n"

# Loop over a list of words (note: quoting matters)
for item in "alpha" "beta" "gamma"; do
  printf "item=%s\n" "$item"
done
printf "\n"

# While read loop (robust file reading)
# (printf used here to avoid creating a file)
printf "Reading lines safely:\n"
printf "line1\nline two\nline3\n" | while IFS= read -r line; do
  printf "  -> %s\n" "$line"
done
printf "\n"

# --- Functions ---
say_hi() {
  local who="${1:-world}"  # local variable + default
  printf "Hi, %s!\n" "$who"
}
say_hi "$name"
say_hi
printf "\n"

# --- Exit codes & short-circuit logic ---
# Commands return status codes: 0 = success, non-zero = failure.
# Use && and || for compact flow.
command -v git >/dev/null 2>&1 && printf "git is installed\n" || printf "git not found\n"
printf "\n"

# --- Redirects & pipes ---
# stdout: 1, stderr: 2
printf "This goes to stdout\n"
printf "This goes to stderr\n" >&2

# Redirect stdout to a file, append with >>, redirect stderr with 2>
tmpfile="$(mktemp)"
printf "writing a line\n" > "$tmpfile"
printf "appending a line\n" >> "$tmpfile"
printf "tmpfile contents:\n"
cat "$tmpfile"
rm -f "$tmpfile"
printf "\n"

# --- Here-doc (multi-line strings) ---
cat <<'EOF'
Here-doc block:
- Useful for config snippets, templates, and long text.
- Quoted delimiter (<<'EOF') prevents expansion of $vars and $(commands).
EOF
printf "\n"

# --- Traps (cleanup on exit / signals) ---
cleanup() {
  # Put cleanup actions here (delete temp files, stop background jobs, etc.)
  :
}
trap cleanup EXIT

# --- Script arguments ---
# $0 script name, $1..$N positional args, "$@" all args (preserves spacing)
printf "Script name: %s\n" "$0"
printf "Number of args: %s\n" "$#"
printf "Args (one per line):\n"
for arg in "$@"; do
  printf "  - %s\n" "$arg"
done
printf "\n"

# --- getopts (basic flag parsing) ---
# Example: ./basics.sh -n 3 -v
verbose=false
num=1
while getopts ":n:v" opt; do
  case "$opt" in
    n) num="$OPTARG" ;;
    v) verbose=true ;;
    \?) printf "Unknown option: -%s\n" "$OPTARG" >&2; exit 2 ;;
    :)  printf "Option -%s requires an argument\n" "$OPTARG" >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

$verbose && printf "verbose enabled\n"
printf "num=%s\n\n" "$num"

# --- Subshells vs current shell ---
# Parentheses run in a subshell; changes don't persist outside.
x="outside"
( x="inside"; printf "In subshell: x=%s\n" "$x" )
printf "Outside: x=%s\n\n" "$x"

printf "Done.\n"
