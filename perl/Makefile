PERL ?= perl
OUTDIR ?= ../outputs

.PHONY: all check run
all: check run

check:
	@echo "==> Perl: syntax check"
	@$(PERL) -c basics.pl >/dev/null

run:
	@echo "==> Perl: running demo"
	@mkdir -p "$(OUTDIR)"
	@$(PERL) basics.pl > "$(OUTDIR)/perl_basics.txt"
	@echo "Wrote perl outputs"

.PHONY: clean
clean:
	@# perl has no build artifacts