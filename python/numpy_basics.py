#!/usr/bin/env python3
"""
NumPy basics / syntax notes

Run:
  python python/numpy_basics.py
"""

from __future__ import annotations

import os
from pathlib import Path

import numpy as np


def section(title: str) -> None:
    print("\n" + "=" * len(title))
    print(title)
    print("=" * len(title))


def main() -> None:
    section("Import + dtype basics")
    a = np.array([1, 2, 3], dtype=np.int64)
    b = np.array([0.1, 0.2, 0.3], dtype=np.float64)
    print("a:", a, a.dtype, a.shape)
    print("b:", b, b.dtype, b.shape)

    section("Creating arrays")
    z = np.zeros((2, 3))
    o = np.ones((2, 3))
    eye = np.eye(3)
    lin = np.linspace(0.0, 1.0, 5)
    ar = np.arange(0, 10, 2)
    print("zeros:\n", z)
    print("ones:\n", o)
    print("eye:\n", eye)
    print("linspace:", lin)
    print("arange:", ar)

    section("Indexing / slicing")
    x = np.arange(12).reshape(3, 4)
    print("x:\n", x)
    print("x[0, :]:", x[0, :])
    print("x[:, 2]:", x[:, 2])
    print("x[1:, 1:3]:\n", x[1:, 1:3])

    section("Views vs copies (important)")
    v = x[:, :2]        # view into x
    c = x[:, :2].copy() # independent copy
    v[0, 0] = -999
    print("after modifying view, x[0,0] changed:", x[0, 0])
    print("copy unaffected:", c[0, 0])

    section("Boolean masks")
    x2 = np.arange(10)
    mask = (x2 % 2 == 0)
    print("x2:", x2)
    print("mask:", mask)
    print("x2[mask]:", x2[mask])

    section("Broadcasting (core concept)")
    M = np.arange(6).reshape(2, 3)
    col = np.array([[10], [100]])  # shape (2,1)
    row = np.array([1, 2, 3])      # shape (3,)
    print("M:\n", M)
    print("M + row:\n", M + row)   # (2,3) + (3,)
    print("M + col:\n", M + col)   # (2,3) + (2,1)

    section("Reductions / axis")
    R = np.arange(12).reshape(3, 4)
    print("R:\n", R)
    print("sum all:", R.sum())
    print("sum axis=0 (columns):", R.sum(axis=0))
    print("sum axis=1 (rows):", R.sum(axis=1))
    print("mean axis=1:", R.mean(axis=1))

    section("Random numbers (Generator API)")
    rng = np.random.default_rng(123)
    samples = rng.normal(loc=0.0, scale=1.0, size=(3, 4))
    print("samples:\n", samples)
    print("samples mean/std:", samples.mean(), samples.std())

    section("Sorting / argsort")
    y = np.array([10, 3, 7, 7, 2])
    idx = np.argsort(y)
    print("y:", y)
    print("argsort idx:", idx)
    print("sorted:", y[idx])

    section("Linear algebra (basic)")
    A = np.array([[3.0, 1.0], [1.0, 2.0]])
    v = np.array([9.0, 8.0])
    sol = np.linalg.solve(A, v)
    eigvals = np.linalg.eigvals(A)
    print("A:\n", A)
    print("solve A x = v -> x:", sol)
    print("eigenvalues:", eigvals)

    section("IO: save/load .npy (fast & simple)")
    outdir = Path(os.environ.get("OUTPUT_DIR", "."))
    outdir.mkdir(parents=True, exist_ok=True)
    tmp = outdir / "_tmp_array.npy"
    np.save(tmp, samples)
    loaded = np.load(tmp)
    print("loaded shape:", loaded.shape, "equal?", np.allclose(loaded, samples))

    section("Gotchas / tips")
    print("- Prefer vectorized ops over Python loops when possible.")
    print("- Use np.asarray() to avoid unnecessary copies.")
    print("- Remember slicing often returns a VIEW; use .copy() if needed.")
    print("- Use float64 for numerics unless you have a reason not to.")


if __name__ == "__main__":
    main()
