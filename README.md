# syntactually

A personal "syntax notebook" repo: short, runnable examples and reminders for languages/tools I use.
Each folder contains small scripts that double as notes and reference material.

## Structure

```md
syntactually/
├── bash/ # Shell scripting + CLI tools (grep, awk, sed)
├── zsh/ # Zsh-specific features and syntax
├── perl/ # Perl basics and idioms
├── python/ # Python syntax + libraries (NumPy, Matplotlib)
├── cpp/ # C++ syntax and STL
├── markdown/ # Markdown patterns and snippets
├── tests/ # Automated test suite
└── outputs/ # Generated output files (gitignored)
```

### Language Folders

- **[bash/](bash/)** — Shell scripting notes, common CLI tools (grep, awk), and patterns
- **[zsh/](zsh/)** — Zsh-specific features: extended globbing, parameter expansion, 1-indexed arrays
- **[perl/](perl/)** — Perl basics and useful idioms
- **[python/](python/)** — Core Python syntax plus NumPy and Matplotlib usage
- **[cpp/](cpp/)** — C++ syntax, STL containers, modern C++ features (C++11/17/20)
- **[markdown/](markdown/)** — Markdown formatting and snippets

## Quick Start

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/nterrel/syntactually.git
   cd syntactually
   ```

2. Set up Python environment (for Python scripts):

   ```bash
   make setup
   ```

### Running Scripts

Run all scripts and generate outputs:

```bash
make all
```

Run specific language notes:

```bash
make bash      # Run bash scripts
make zsh       # Run zsh scripts
make perl      # Run perl scripts
make python    # Run python scripts
make cpp       # Build and run C++ programs
```

Or use the convenience wrapper:

```bash
./run_scripts.sh all
./run_scripts.sh bash
./run_scripts.sh python
```

### Testing

Run the test suite to verify everything works:

```bash
make test
```

Run linters (requires shellcheck and ruff):

```bash
make lint
```

## Output Files

Scripts generate output files in the `outputs/` directory:

- `bash_basics.txt` - Bash syntax examples
- `bash_grep.txt` - grep patterns and usage
- `bash_awk.txt` - awk field processing examples
- `zsh_basics.txt` - Zsh-specific features and syntax
- `zsh_functions.txt` - Zsh functions and advanced features
- `perl_basics.txt` - Perl syntax demonstrations
- `python_basics.txt` - Python core syntax
- `python_numpy.txt` - NumPy array operations
- `python_matplotlib.txt` - Matplotlib plotting
- `cpp_basics.txt` - C++ syntax and features

## Prerequisites

- **Bash** (standard on macOS/Linux)
- **Zsh** (standard on macOS, available on most Linux)
- **Perl** (standard on macOS/Linux)
- **Python 3.10+**
- **C++ compiler** (g++ or clang++, with C++20 support)
- **Make** (for running targets)

Optional for linting:

- **shellcheck** - Bash script linting
- **ruff** - Python linting (installed with `make setup`)

## Clean Up

Remove generated outputs and caches:

```bash
make clean
```
