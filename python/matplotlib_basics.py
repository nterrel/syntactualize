#!/usr/bin/env python3
"""
Matplotlib basics / syntax notes

Run:
  python python/matplotlib_basics.py

Outputs:
  matplotlib_line.png
  matplotlib_scatter.png
  matplotlib_hist.png
"""

from __future__ import annotations

import os
from pathlib import Path

import numpy as np
import matplotlib.pyplot as plt


def section(title: str) -> None:
    print("\n" + "=" * len(title))
    print(title)
    print("=" * len(title))

outdir = Path(os.environ.get("OUTPUT_DIR", "."))
outdir.mkdir(parents=True, exist_ok=True)

def save(fig: plt.Figure, filename: str) -> None:
    path = outdir / filename
    fig.tight_layout()
    fig.savefig(filename, dpi=200)
    plt.close(fig)
    print("wrote", filename)


def main() -> None:
    rng = np.random.default_rng(0)

    section("1) Simple line plot")
    x = np.linspace(0, 2 * np.pi, 200)
    y = np.sin(x)

    fig, ax = plt.subplots()
    ax.plot(x, y, label="sin(x)")
    ax.set_title("Line plot")
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.legend()
    ax.grid(True)
    save(fig, "matplotlib_line.png")

    section("2) Scatter plot with annotations")
    xs = rng.normal(size=200)
    ys = 0.5 * xs + rng.normal(scale=0.5, size=200)

    fig, ax = plt.subplots()
    ax.scatter(xs, ys, s=15, alpha=0.8)
    ax.set_title("Scatter")
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.grid(True)
    ax.text(0.02, 0.98, "example annotation", transform=ax.transAxes, va="top")
    save(fig, "matplotlib_scatter.png")

    section("3) Histogram")
    data = rng.normal(loc=0.0, scale=1.0, size=5000)

    fig, ax = plt.subplots()
    ax.hist(data, bins=50)
    ax.set_title("Histogram")
    ax.set_xlabel("value")
    ax.set_ylabel("count")
    ax.grid(True)
    save(fig, "matplotlib_hist.png")

    section("Common patterns / tips")
    print("- Prefer fig, ax = plt.subplots() and call methods on ax.")
    print("- Use fig.savefig(...) for scripts; plt.show() for interactive use.")
    print("- Call plt.close(fig) in scripts to avoid memory growth.")
    print("- Keep plotting code separate from data-loading/processing.")


if __name__ == "__main__":
    main()
