SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help

OUTDIR := $(CURDIR)/outputs

# Subdirectories with Makefiles
SUBDIRS := bash perl python zsh cpp

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make all        - run all language demos"
	@echo "  make bash       - bash scripts"
	@echo "  make perl       - perl scripts"
	@echo "  make python     - python demos"
	@echo "  make zsh        - zsh scripts"
	@echo "  make cpp        - C++ examples"
	@echo "  make test       - run test suite"
	@echo "  make clean      - remove outputs and caches"

.PHONY: prepare
prepare:
	@mkdir -p "$(OUTDIR)"

.PHONY: setup
setup:
	@$(MAKE) -C python setup

# Delegate to subdirectory Makefiles
.PHONY: bash perl python zsh cpp
$(SUBDIRS):
	@$(MAKE) -C $@ OUTDIR="$(OUTDIR)"

.PHONY: all
all: prepare $(SUBDIRS)
	@echo ""
	@echo "==> All done"
	@echo "Outputs captured in: $(OUTDIR)/"

# Convenience targets for checking syntax only
.PHONY: bash-check perl-check python-check zsh-check cpp-check
bash-check:
	@$(MAKE) -C bash check

perl-check:
	@$(MAKE) -C perl check

python-check:
	@$(MAKE) -C python check

zsh-check:
	@$(MAKE) -C zsh check

cpp-check:
	@$(MAKE) -C cpp check

.PHONY: test
test: all
	@if [ -f python/.venv/bin/python ]; then \
		python/.venv/bin/python -m pytest tests/ -v; \
	else \
		echo "Error: Python venv not found. Run 'make setup' first."; \
		exit 1; \
	fi

.PHONY: clean
clean:
	@rm -rf "$(OUTDIR)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@for dir in $(SUBDIRS); do \
		if [ -f "$$dir/Makefile" ]; then \
			$(MAKE) -C $$dir clean 2>/dev/null || true; \
		fi; \
	done