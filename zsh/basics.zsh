#!/usr/bin/env zsh
#
# Zsh basics / syntax notes
# Run: zsh zsh/basics.zsh
# Make executable: chmod +x zsh/basics.zsh
#

# --- Zsh-specific options (can be more permissive than bash) ---
# setopt for enabling options, unsetopt for disabling
# Common strict mode equivalents:
# setopt ERR_EXIT        # like set -e
# setopt NO_UNSET        # like set -u
# setopt PIPE_FAIL       # like set -o pipefail

# For scripts, consider:
setopt ERR_EXIT NO_UNSET PIPE_FAIL

printf "Hi from Zsh!\n"
printf "Zsh has many bash-compatible features plus powerful extensions.\n\n"

# --- Variables (similar to bash) ---
count=5
name="Nick"

printf "count=%s, name=%s\n" "$count" "$name"

# Braces for concatenation
file="data"
printf "Example: %s\n\n" "${file}_001.txt"

# --- Arrays (1-INDEXED in zsh, unlike bash!) ---
# This is a major difference from bash
arr=("One" "Two words" "Three")

# Array indices start at 1
printf "arr[1]=%s (note: 1-indexed!)\n" "${arr[1]}"
printf "arr[2]=%s\n" "${arr[2]}"

# All elements
printf "All elements:\n"
for x in "${arr[@]}"; do
  printf "  - %s\n" "$x"
done

# Array length
printf "Array length: %s\n\n" "${#arr}"

# Array slicing (very powerful in zsh)
printf "Slice [1,2]: %s\n\n" "${arr[1,2]}"

# --- Associative Arrays (built-in, no version check needed!) ---
# Zsh has native associative array support
typeset -A dict
dict[One]=1
dict[Two]=2
dict[Three]=3

printf "dict[One]=%s\n" "${dict[One]}"
printf "Keys:\n"
for k in "${(@k)dict}"; do
  printf "  %s => %s\n" "$k" "${dict[$k]}"
done
printf "\n"

# --- Parameter Expansion Flags ---
# Zsh has powerful expansion flags with (flag) syntax

# Uppercase
text="hello world"
printf "Original: %s\n" "$text"
printf "Uppercase: %s\n" "${(U)text}"
printf "Lowercase: %s\n" "${(L)text}"
printf "Capitalize: %s\n\n" "${(C)text}"

# Join array elements
colors=("red" "green" "blue")
printf "Joined with commas: %s\n" "${(j:,:)colors}"
printf "Joined with ' | ': %s\n\n" "${(j: | :)colors}"

# Split string into array
sentence="the quick brown fox"
words=("${(@s: :)sentence}")
printf "Split into %d words:\n" "${#words}"
for w in "${words[@]}"; do
  printf "  - %s\n" "$w"
done
printf "\n"

# --- Arithmetic (similar to bash) ---
a=7
b=3
sum=$((a + b))
printf "%s + %s = %s\n" "$a" "$b" "$sum"

# Zsh also supports floating point!
float_result=$((3.14 * 2.0))
printf "Float math: 3.14 * 2.0 = %s\n\n" "$float_result"

# --- Conditionals (similar to bash, but more features) ---
if [[ $count -gt 3 ]]; then
  printf "count > 3\n"
fi

# String matching with patterns
if [[ $name == N* ]]; then
  printf "name starts with N\n"
fi

# Regex matching (like bash)
if [[ $name =~ ^[A-Z] ]]; then
  printf "name starts with uppercase letter\n\n"
fi

# --- Extended Globbing ---
# Zsh globbing is incredibly powerful
# Enable extended globbing (often on by default)
setopt EXTENDED_GLOB

printf "Extended globbing examples:\n"
printf "  **/*.txt  - recursive search for .txt files\n"
printf "  *.{sh,zsh} - match .sh or .zsh files\n"
printf "  *.(jpg|png) - match images\n"
printf "  *(.) - only regular files\n"
printf "  *(/) - only directories\n"
printf "  *(L0) - empty files\n"
printf "  *(Om) - sort by modification time (newest first)\n\n"

# Demonstrate with arrays (won't actually glob in this script context)
# In real usage: files=( **/*.txt(.) )  # all .txt files recursively

# --- Glob Qualifiers ---
printf "Glob qualifier examples:\n"
printf "  *(.)     - regular files only\n"
printf "  *(/)     - directories only\n"
printf "  *(^/)    - not directories (files, symlinks, etc)\n"
printf "  *(@)     - symbolic links\n"
printf "  *(x)     - executable files\n"
printf "  *(r)     - readable files\n"
printf "  *(om)    - sort by modification time, oldest first\n"
printf "  *(Om[1,5]) - newest 5 files\n\n"

# --- Functions ---
greet() {
  local person="$1"
  printf "Hello, %s!\n" "$person"
}

greet "Zsh user"

# Function with multiple arguments
calculate() {
  local x=$1 y=$2
  printf "%s + %s = %s\n" "$x" "$y" "$((x + y))"
}

calculate 10 20
printf "\n"

# --- Loops ---
printf "For loop with range:\n"
for i in {1..5}; do
  printf "  i=%s\n" "$i"
done

printf "\nWhile loop:\n"
counter=1
while (( counter <= 3 )); do
  printf "  counter=%s\n" "$counter"
  ((counter++))
done
printf "\n"

# --- Command Substitution ---
current_date="$(date +%Y-%m-%d)"
printf "Today is %s\n\n" "$current_date"

# --- Aliases (zsh has global and suffix aliases too!) ---
# Regular alias (like bash)
# alias ll='ls -lah'

# Global alias (expands anywhere in command line, not just at start)
# alias -g L='| less'
# Example: cat file.txt L  # expands to: cat file.txt | less

# Suffix alias (auto-opens files by extension)
# alias -s txt=vim  # typing file.txt runs: vim file.txt
# alias -s pdf=open

printf "Zsh alias types:\n"
printf "  alias x=y      - regular alias (command start only)\n"
printf "  alias -g G=... - global alias (expands anywhere)\n"
printf "  alias -s ext=cmd - suffix alias (auto-open by extension)\n\n"

# --- Process Substitution ---
# Works like bash: <(command) and >(command)
printf "Process substitution (like bash):\n"
printf "  diff <(ls dir1) <(ls dir2)\n"
printf "  grep pattern <(curl url)\n\n"

# --- Here Documents ---
printf "Here document example:\n"
cat <<EOF
This is a multi-line
here document. Variables
like \$name expand: $name
EOF
printf "\n"

# --- Redirection ---
# Standard redirections (like bash)
printf "Redirection examples:\n"
printf "  cmd > file     - stdout to file (overwrite)\n"
printf "  cmd >> file    - stdout to file (append)\n"
printf "  cmd 2> file    - stderr to file\n"
printf "  cmd &> file    - both stdout and stderr\n"
printf "  cmd >& file    - zsh style for both\n"
printf "  cmd >&1        - redirect to stdout\n\n"

# --- Zsh-specific: Named directories ---
# ~name expands to directories
# Example: hash -d proj=~/projects/myproject
# Then: cd ~proj
printf "Named directories:\n"
printf "  hash -d name=/path/to/dir\n"
printf "  cd ~name\n\n"

# --- Prompt Expansion ---
# Zsh has very powerful prompt customization
printf "Prompt expansion examples:\n"
printf "  %%n - username\n"
printf "  %%m - hostname\n"
printf "  %%~ - current directory (with ~)\n"
printf "  %%T - current time\n"
printf "  %%# - # for root, %% for normal user\n\n"

# --- History ---
printf "History commands:\n"
printf "  history     - show command history\n"
printf "  !!          - repeat last command\n"
printf "  !$          - last argument of last command\n"
printf "  !^          - first argument of last command\n"
printf "  !*          - all arguments of last command\n\n"

# --- Exit status ---
# $? holds exit status of last command
# 0 = success, non-zero = failure
true
printf "Exit status of 'true': %s\n" "$?"

false || printf "Exit status of 'false': 1 (caught with ||)\n\n"

# --- Special Variables ---
printf "Special variables:\n"
printf "  \$0      - script name: %s\n" "$0"
printf "  \$#      - number of arguments: %s\n" "$#"
printf "  \$@      - all arguments\n"
printf "  \$?      - exit status of last command\n"
printf "  \$\$      - current process ID: %s\n" "$$"
printf "  \$!      - PID of last background command\n"
printf "  \$-      - current shell options\n\n"

# --- Zsh Modules ---
printf "Zsh has loadable modules for extra functionality:\n"
printf "  zmodload zsh/datetime    - date/time functions\n"
printf "  zmodload zsh/mathfunc    - math functions (sin, cos, etc)\n"
printf "  zmodload zsh/stat        - file stat functions\n"
printf "  zmodload zsh/zpty        - pseudo-terminal support\n\n"

# --- Tips ---
printf "Useful Zsh tips:\n"
printf "  - Arrays are 1-indexed (unlike bash's 0-indexed)\n"
printf "  - Use setopt/unsetopt to configure behavior\n"
printf "  - Extended globbing is incredibly powerful (**/, qualifiers)\n"
printf "  - Parameter expansion flags (U, L, j, s) are super useful\n"
printf "  - zmv for batch renaming (autoload zmv)\n"
printf "  - Use 'whence -v cmd' to find where command comes from\n"
printf "  - Completion system is very powerful (compinit)\n\n"

printf "Done! This covers core Zsh syntax and features.\n"
