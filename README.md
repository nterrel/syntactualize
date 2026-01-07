# syntactualize

![CI](https://github.com/nickterrel/syntactualize/workflows/CI/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A personal "syntax notebook" repo: short, runnable examples and reminders for languages/tools I use.
Each folder contains small scripts that double as notes and reference material.

## Features

- ✅ **Executable documentation** - All scripts run and produce outputs
- ✅ **CI-verified** - GitHub Actions ensures everything works
- ✅ **Self-contained** - Scripts are standalone and well-commented
- ✅ **Multi-language** - Bash, Perl, Python, and Markdown examples

## Structure

```
syntactualize/
├── bash/           # Shell scripting + CLI tools (grep, awk, sed)
├── perl/           # Perl basics and idioms
├── python/         # Python syntax + libraries (NumPy, Matplotlib)
├── markdown/       # Markdown patterns and snippets
├── tests/          # Automated test suite
└── outputs/        # Generated output files (gitignored)
```

### Language Folders

- **[bash/](bash/)** — Shell scripting notes, common CLI tools (grep, awk), and patterns
- **[perl/](perl/)** — Perl basics and useful idioms
- **[python/](python/)** — Core Python syntax plus NumPy and Matplotlib usage
- **[markdown/](markdown/)** — Markdown formatting and snippets

## Quick Start

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/nterrel/syntactualize.git
   cd syntactualize
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

Run specific language demos:

```bash
make bash      # Run bash scripts
make perl      # Run perl scripts
make python    # Run python scripts
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
- `perl_basics.txt` - Perl syntax demonstrations
- `python_basics.txt` - Python core syntax
- `python_numpy.txt` - NumPy array operations
- `python_matplotlib.txt` - Matplotlib plotting

## Development

### Prerequisites

- **Bash** (standard on macOS/Linux)
- **Perl** (standard on macOS/Linux)
- **Python 3.10+**
- **Make** (for running targets)

Optional for linting:

- **shellcheck** - Bash script linting
- **ruff** - Python linting (installed with `make setup`)

### Adding New Scripts

1. Create your script in the appropriate language folder
2. Add syntax check and run commands to the Makefile
3. Update the folder's README with script description
4. Add tests in `tests/` to verify the script works
5. Run `make all` and `make test` to verify

### Clean Up

Remove generated outputs and caches:

```bash
make clean
```

## CI/CD

GitHub Actions automatically:

- Tests on Ubuntu and macOS
- Validates with Python 3.10, 3.11, and 3.12
- Runs all scripts and verifies outputs
- Performs linting checks
- Runs the test suite

See [.github/workflows/ci.yml](.github/workflows/ci.yml) for details.

## License

MIT License - see [LICENSE](LICENSE) file for details.
