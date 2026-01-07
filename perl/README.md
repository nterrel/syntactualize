# Basics of Perl

Runnable notes for basic Perl syntax and data structures.

## Files

- `basics.pl` — print statements, comments, scalars/arrays/hashes, loops, and simple examples.

## Run

Using Makefile targets (recommended):

```bash
make perl        # Syntax check + run demo
make perl-check  # Syntax check only
```

Or run directly:

```bash
perl basics.pl
# or:
chmod +x basics.pl
./basics.pl
```

## Testing

Scripts are automatically tested via `make test` and in CI to ensure they run without errors.
