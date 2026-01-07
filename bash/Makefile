OUTDIR ?= ../outputs

.PHONY: all check run
all: check run

check:
	@echo "==> Bash: syntax checks"
	@bash -n basics.sh
	@bash -n grep.sh
	@bash -n awk.sh

run:
	@echo "==> Bash: running demos"
	@mkdir -p "$(OUTDIR)"
	@./basics.sh > "$(OUTDIR)/bash_basics.txt"
	@./grep.sh > "$(OUTDIR)/bash_grep.txt"
	@./awk.sh > "$(OUTDIR)/bash_awk.txt"
	@echo "Wrote bash outputs"

.PHONY: clean
clean:
	@# bash has no build artifacts