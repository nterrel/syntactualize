CXX ?= g++
CXXFLAGS ?= -std=c++20 -Wall -Wextra -O2
OUTDIR ?= ../outputs

SOURCES := $(wildcard *.cpp)
TARGETS := $(SOURCES:.cpp=.o)

.PHONY: all check run
all: check $(TARGETS) run

check:
	@echo "==> C++: syntax checks"
	@for src in $(SOURCES); do \
		$(CXX) $(CXXFLAGS) -fsyntax-only $$src && echo "  ✓ $$src"; \
	done

%.o: %.cpp
	@$(CXX) $(CXXFLAGS) -o $@ $<

run: $(TARGETS)
	@echo "==> C++: running demos"
	@mkdir -p "$(OUTDIR)"
	@for prog in $(TARGETS); do \
		base=$${prog%.o}; \
		./$$prog > "$(OUTDIR)/cpp_$$base.txt" && echo "  ✓ $$prog"; \
	done

.PHONY: clean
clean:
	@rm -f $(TARGETS) *.o