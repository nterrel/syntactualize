# Tests

Automated test suite for validating all scripts and outputs.

## Test Structure

- `conftest.py` - Pytest fixtures and configuration
- `test_outputs.py` - Validates script output files are generated correctly
- `test_scripts_syntax.py` - Checks syntax of all bash, perl, and python scripts
- `test_makefile.py` - Tests Makefile targets work correctly

## Running Tests

Run all tests:
```bash
make test
```

Run with pytest directly (requires activated venv):
```bash
source python/.venv/bin/activate
pytest tests/ -v
```

Run specific test file:
```bash
pytest tests/test_outputs.py -v
```

Run specific test:
```bash
pytest tests/test_outputs.py::TestBashOutputs::test_bash_basics_output_exists -v
```

## What Tests Verify

### Output Generation
- All expected output files are created in `outputs/`
- Output files contain meaningful content
- Output files have expected keywords/patterns

### Script Syntax
- All bash scripts pass `bash -n` syntax check
- All perl scripts pass `perl -c` syntax check
- All python scripts can be compiled

### Makefile Targets
- All make targets execute without errors
- `make help` displays usage information
- `make prepare` creates necessary directories

## Adding New Tests

When adding a new script:

1. Add output validation in `test_outputs.py`
2. Add syntax check in `test_scripts_syntax.py`
3. Update Makefile targets if needed
4. Run `make test` to verify

## CI Integration

These tests run automatically in GitHub Actions on:
- Every push to main/master
- Every pull request
- Multiple OS (Ubuntu, macOS)
- Multiple Python versions (3.10, 3.11, 3.12)
