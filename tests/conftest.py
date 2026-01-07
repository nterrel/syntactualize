"""Pytest configuration and fixtures."""

from pathlib import Path

import pytest


@pytest.fixture(scope="session")
def repo_root() -> Path:
    """Return the repository root directory."""
    return Path(__file__).parent.parent


@pytest.fixture(scope="session")
def outputs_dir(repo_root: Path) -> Path:
    """Return the outputs directory."""
    return repo_root / "outputs"


@pytest.fixture(scope="session")
def bash_dir(repo_root: Path) -> Path:
    """Return the bash scripts directory."""
    return repo_root / "bash"


@pytest.fixture(scope="session")
def perl_dir(repo_root: Path) -> Path:
    """Return the perl scripts directory."""
    return repo_root / "perl"


@pytest.fixture(scope="session")
def python_dir(repo_root: Path) -> Path:
    """Return the python scripts directory."""
    return repo_root / "python"
