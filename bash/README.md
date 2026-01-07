# Bash syntax and snippets

## Files

- `basics.sh` — variables, quoting, arrays, loops, functions, traps, redirects, `getopts`, etc.
- `grep.sh` — grep patterns and options (regex basics, context, counting, `-F`, `-E`, etc.)
- `awk.sh` — awk fields, filters, `BEGIN/END`, basic aggregations, formatting, etc.

## Run

Using Makefile targets (recommended):

```bash
make bash        # Syntax check + run all scripts
make bash-check  # Syntax check only
```

Or run scripts directly:

```bash
chmod +x basics.sh grep.sh awk.sh

./basics.sh
./grep.sh
./awk.sh
```

## Testing

Scripts are automatically tested via `make test` and in CI to ensure they run without errors and produce expected outputs.
