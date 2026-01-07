"""Test Makefile targets work correctly."""

import subprocess
from pathlib import Path


class TestMakefileTargets:
    """Test that Makefile targets execute successfully."""

    def test_make_help(self, repo_root: Path) -> None:
        """Test that make help runs without error."""
        result = subprocess.run(
            ["make", "help"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"make help failed:\n{result.stderr}"
        assert "Targets:" in result.stdout, "Help output should list targets"

    def test_make_prepare(self, repo_root: Path) -> None:
        """Test that make prepare creates outputs directory."""
        result = subprocess.run(
            ["make", "prepare"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"make prepare failed:\n{result.stderr}"
        assert (repo_root / "outputs").exists(), "outputs/ should be created"

    def test_make_bash_check(self, repo_root: Path) -> None:
        """Test that make bash-check runs successfully."""
        result = subprocess.run(
            ["make", "bash-check"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"make bash-check failed:\n{result.stderr}"

    def test_make_perl_check(self, repo_root: Path) -> None:
        """Test that make perl-check runs successfully."""
        result = subprocess.run(
            ["make", "perl-check"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"make perl-check failed:\n{result.stderr}"

    def test_make_python_check(self, repo_root: Path) -> None:
        """Test that make python-check runs successfully."""
        result = subprocess.run(
            ["make", "python-check"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"make python-check failed:\n{result.stderr}"


class TestRunScriptsShell:
    """Test run_scripts.sh wrapper."""

    def test_run_scripts_help(self, repo_root: Path) -> None:
        """Test that run_scripts.sh can invoke make help."""
        script_path = repo_root / "run_scripts.sh"

        result = subprocess.run(
            [str(script_path), "help"],
            cwd=repo_root,
            capture_output=True,
            text=True,
        )

        assert result.returncode == 0, f"run_scripts.sh help failed:\n{result.stderr}"
        assert "Targets:" in result.stdout, "Should show make help output"
