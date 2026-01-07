SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help

# Prefer the venv inside python/
VENV_PY := $(CURDIR)/python/.venv/bin/python
PY ?= $(shell [[ -x "$(VENV_PY)" ]] && echo "$(VENV_PY)" || echo python3)

PERL ?= perl
OUTDIR := outputs

# --- helpers ---
define print_header
	@echo ""
	@echo "==> $(subst ",,$(1))"
endef

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make all        - run bash + perl + python (and basic checks)"
	@echo "  make bash       - shell scripts: syntax check + run demos"
	@echo "  make perl       - perl script: syntax check + run demo"
	@echo "  make python     - python: compileall + run demos"
	@echo "  make test       - run test suite with pytest"
	@echo "  make lint       - optional linters if installed (shellcheck, ruff)"
	@echo "  make clean      - remove outputs and caches"
	@echo ""
	@echo "Convenience:"
	@echo "  ./run_scripts.sh [target]   - wrapper around make"

.PHONY: prepare
prepare:
	@mkdir -p "$(OUTDIR)"

.PHONY: setup
setup:
	$(call print_header,Python: setting up venv and installing deps)
	@python3 -m venv python/.venv
	@$(VENV_PY) -m pip install -U pip
	@$(VENV_PY) -m pip install -e "./python[dev]"
	@echo "Activate with: source python/.venv/bin/activate"

# --- bash ---
.PHONY: bash bash-check bash-run
bash: bash-check bash-run

bash-check:
	$(call print_header,"Bash: syntax checks")
	@bash -n bash/basics.sh
	@bash -n bash/grep.sh
	@bash -n bash/awk.sh

bash-run: prepare
	$(call print_header,"Bash: running demos (capturing output)")
	@./bash/basics.sh > "$(OUTDIR)/bash_basics.txt"
	@./bash/grep.sh   > "$(OUTDIR)/bash_grep.txt"
	@./bash/awk.sh    > "$(OUTDIR)/bash_awk.txt"
	@echo "Wrote: $(OUTDIR)/bash_basics.txt, bash_grep.txt, bash_awk.txt"

# --- perl ---
.PHONY: perl perl-check perl-run
perl: perl-check perl-run

perl-check:
	$(call print_header,"Perl: syntax check")
	@$(PERL) -c perl/basics.pl >/dev/null

perl-run: prepare
	$(call print_header,"Perl: running demo (capturing output)")
	@$(PERL) perl/basics.pl > "$(OUTDIR)/perl_basics.txt"
	@echo "Wrote: $(OUTDIR)/perl_basics.txt"

# --- python ---
# NOTE: avoid naming files python/numpy.py or python/matplotlib.py
# because they can shadow real packages when running from that directory.
.PHONY: python python-check python-run
python: python-check python-run

python-check:
	$(call print_header,"Python: compileall")
	@$(PY) -m compileall -q python

python-run: prepare
	$(call print_header,Python: running demos (capturing output))
	@cd "$(OUTDIR)" && $(PY) ../python/basics.py > python_basics.txt

	@cd "$(OUTDIR)" && if [[ -f ../python/numpy_basics.py ]]; then \
		$(PY) ../python/numpy_basics.py > python_numpy.txt; \
	elif [[ -f ../python/numpy.py ]]; then \
		$(PY) ../python/numpy.py > python_numpy.txt; \
	else \
		echo "Skipping NumPy demo: python/numpy_basics.py not found" > python_numpy.txt; \
	fi

	@cd "$(OUTDIR)" && if [[ -f ../python/matplotlib_basics.py ]]; then \
		$(PY) ../python/matplotlib_basics.py > python_matplotlib.txt; \
	elif [[ -f ../python/matplotlib.py ]]; then \
		$(PY) ../python/matplotlib.py > python_matplotlib.txt; \
	else \
		echo "Skipping Matplotlib demo: python/matplotlib_basics.py not found" > python_matplotlib.txt; \
	fi

	@echo "Wrote: $(OUTDIR)/python_basics.txt, python_numpy.txt, python_matplotlib.txt"

# --- tests ---
.PHONY: test
test:
	$(call print_header,"Running test suite")
	@$(PY) -m pytest tests/ -v

# --- optional linting (won't fail if tools missing) ---
.PHONY: lint
lint:
	$(call print_header,"Optional linters (if installed)")
	@if command -v shellcheck >/dev/null 2>&1; then \
		echo "shellcheck bash/*.sh"; \
		shellcheck bash/*.sh; \
	else \
		echo "shellcheck not installed (skipping)"; \
	fi
	@if command -v ruff >/dev/null 2>&1; then \
		echo "ruff check python"; \
		ruff check python; \
	else \
		echo "ruff not installed (skipping)"; \
	fi

# --- meta targets ---
.PHONY: all
all: bash perl python
	$(call print_header,"All done")
	@echo "Outputs captured in: $(OUTDIR)/"

.PHONY: clean
clean:
	$(call print_header,"Cleaning outputs and caches")
	@rm -rf "$(OUTDIR)"
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} \; 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
