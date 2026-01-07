#!/usr/bin/env python3
"""
Python basics / syntax notes

Run:
  python python/basics.py
"""

from __future__ import annotations

from collections.abc import Iterable, Iterator
from dataclasses import dataclass
from pathlib import Path


def section(title: str) -> None:
    print("\n" + "=" * len(title))
    print(title)
    print("=" * len(title))


def demo_printing_and_strings() -> None:
    section("Printing, strings, f-strings, repr")
    name = "Nick"
    count = 5

    print("Hello!")
    print(f"name={name}, count={count}")
    print(f"repr(name)={name!r}")  # show quotes/escapes
    print("newline:\nsecond line")
    print(r"raw string keeps backslashes: \n \t")


def demo_numbers_and_bool() -> None:
    section("Numbers, booleans")
    a = 7
    b = 3
    print("a+b =", a + b)
    print("a/b =", a / b)   # float division
    print("a//b =", a // b)  # integer floor division
    print("a%b =", a % b)   # modulo
    print("a**b =", a**b)   # power

    x = True
    y = False
    print("x and y =", x and y)
    print("x or y  =", x or y)
    print("not x   =", not x)


def demo_collections() -> None:
    section("Lists, tuples, dicts, sets")
    items = ["one", "two", "three"]
    items.append("four")
    print("list:", items)
    print("slice items[1:3]:", items[1:3])

    tup = (1, 2, 3)
    print("tuple:", tup)

    d = {"One": 1, "Two": 2, "Three": 3}
    print("dict keys:", list(d.keys()))
    print("dict value for 'Two':", d["Two"])
    print("dict get with default:", d.get("Missing", 999))

    s = {"a", "b", "c"}  # sets have unique elements
    s.add("a")  # duplicate ignored
    print("set:", s)
    print("set contains 'a'?", "a" in s)


def demo_control_flow() -> None:
    section("If / for / while / match")
    n = 10
    if n > 5:
        print("n > 5")

    for i in range(3):
        print("for i:", i)

    i = 0
    while i < 3:
        print("while i:", i)
        i += 1

    # Python 3.10+: structural pattern matching (optional but handy)
    value = ("point", 3, 4)
    match value:
        case ("point", x, y):
            print(f"matched point x={x} y={y}")
        case _:
            print("no match")


def demo_comprehensions() -> None:
    section("Comprehensions")
    squares = [i * i for i in range(6)]
    print("squares:", squares)

    evens = {i for i in range(10) if i % 2 == 0}
    print("evens set:", evens)

    d = {k: k.upper() for k in ["a", "b", "c"]}
    print("dict comp:", d)


def greet(who: str = "world") -> str:
    return f"Hello, {who}!"


def demo_functions_args_kwargs() -> None:
    section("Functions, *args, **kwargs")

    def f(a: int, b: int = 2, *args: int, scale: float = 1.0, **kwargs: object) -> float:
        total = a + b + sum(args)
        total *= scale
        if kwargs:
            print("kwargs:", kwargs)
        return total

    print(greet("Nick"))
    print("f:", f(1, 2, 3, 4, scale=0.5, note="example"))


def demo_exceptions() -> None:
    section("Exceptions")
    try:
        int("not_an_int")
    except ValueError as e:
        print("caught ValueError:", e)
    finally:
        print("finally always runs")


def demo_paths_and_files() -> None:
    section("Pathlib (paths/files)")
    here = Path(__file__).resolve()
    print("this file:", here.name)
    print("directory:", here.parent)

    # Create a small file and read it back
    tmp = here.parent / "_tmp_demo.txt"
    tmp.write_text("hello\nworld\n", encoding="utf-8")
    text = tmp.read_text(encoding="utf-8")
    print("file contents:", text.strip().splitlines())
    tmp.unlink(missing_ok=True)


@dataclass
class Point:
    x: float
    y: float

    def norm(self) -> float:
        return (self.x**2 + self.y**2) ** 0.5


def demo_dataclasses_and_typing() -> None:
    section("Dataclasses + typing")
    p = Point(3.0, 4.0)
    print("point:", p)
    print("norm:", p.norm())


def count_lines(lines: Iterable[str]) -> int:
    return sum(1 for _ in lines)


def demo_iterators_generators() -> None:
    section("Iterators / generators")

    def gen(n: int) -> Iterator[int]:
        for i in range(n):
            yield i * 10

    g = gen(4)
    print("generated:", list(g))

    print("count_lines:", count_lines(["a\n", "b\n", "c\n"]))


def main() -> None:
    demo_printing_and_strings()
    demo_numbers_and_bool()
    demo_collections()
    demo_control_flow()
    demo_comprehensions()
    demo_functions_args_kwargs()
    demo_exceptions()
    demo_paths_and_files()
    demo_dataclasses_and_typing()
    demo_iterators_generators()

    section("Main guard / CLI note")
    print("Put CLI parsing in main(), and protect with if __name__ == '__main__':")


if __name__ == "__main__":
    main()
