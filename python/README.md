# Python

Runnable notes about Python syntax, plus small focused scripts for common scientific tools.

## Files

- `basics.py` — core Python syntax: strings, collections, control flow, functions, exceptions,
  pathlib, dataclasses, generators.
- `numpy_basics.py` — array creation, indexing/slicing, views vs copies, broadcasting, reductions,
  RNG, sorting, basic linear algebra, simple `.npy` IO.
- `matplotlib_basics.py` — basic plotting patterns (line/scatter/hist) and saving figures to files.

## Setup

Create and activate the virtual environment:

```bash
make setup  # From repo root - creates .venv and installs dependencies
source .venv/bin/activate
```

## Run

Using Makefile targets (recommended):

```bash
make python        # Syntax check + run all demos
make python-check  # Syntax check only
```

Or run scripts directly:

```bash
python3 basics.py
python3 numpy_basics.py
python3 matplotlib_basics.py
```

## Testing

Scripts are automatically tested via `make test` and in CI to verify syntax, execution, and output generation.

## Linting

Code is formatted and linted with ruff:

```bash
make lint  # Run all linters including ruff
```
