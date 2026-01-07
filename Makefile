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

.PHONY: test
test:
	@python3 -m pytest tests/ -v

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