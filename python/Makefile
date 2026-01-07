VENV_PY := $(CURDIR)/.venv/bin/python
PY ?= $(shell [[ -x "$(VENV_PY)" ]] && echo "$(VENV_PY)" || echo python3)
OUTDIR ?= ../outputs

.PHONY: all setup check run
all: check run

setup:
	@echo "==> Python: setting up venv"
	@python3 -m venv .venv
	@$(VENV_PY) -m pip install -U pip
	@$(VENV_PY) -m pip install -e ".[dev]"

check:
	@echo "==> Python: compileall"
	@$(PY) -m compileall -q .

run:
	@echo "==> Python: running demos"
	@mkdir -p "$(OUTDIR)"
	@cd "$(OUTDIR)" && $(PY) ../python/basics.py > python_basics.txt
	@cd "$(OUTDIR)" && $(PY) ../python/numpy_basics.py > python_numpy.txt 2>/dev/null || echo "NumPy not available" > python_numpy.txt
	@cd "$(OUTDIR)" && $(PY) ../python/matplotlib_basics.py > python_matplotlib.txt 2>/dev/null || echo "Matplotlib not available" > python_matplotlib.txt
	@echo "Wrote python outputs"

.PHONY: clean
clean:
	@rm -rf __pycache__ .pytest_cache *.egg-info