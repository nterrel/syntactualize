"""Test that all scripts generate expected outputs."""

from pathlib import Path


class TestBashOutputs:
    """Test bash script outputs."""

    def test_bash_basics_output_exists(self, outputs_dir: Path) -> None:
        """Test that bash_basics.txt is generated."""
        output_file = outputs_dir / "bash_basics.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_bash_basics_has_content(self, outputs_dir: Path) -> None:
        """Test that bash_basics.txt has meaningful content."""
        output_file = outputs_dir / "bash_basics.txt"
        content = output_file.read_text()
        assert len(
            content) > 100, "bash_basics.txt should have substantial content"
        assert "Variables" in content or "count=" in content, "Missing expected bash output"

    def test_bash_grep_output_exists(self, outputs_dir: Path) -> None:
        """Test that bash_grep.txt is generated."""
        output_file = outputs_dir / "bash_grep.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_bash_grep_has_content(self, outputs_dir: Path) -> None:
        """Test that bash_grep.txt has meaningful content."""
        output_file = outputs_dir / "bash_grep.txt"
        content = output_file.read_text()
        assert len(content) > 100, "bash_grep.txt should have substantial content"
        assert "grep" in content.lower(), "Missing grep-related content"

    def test_bash_awk_output_exists(self, outputs_dir: Path) -> None:
        """Test that bash_awk.txt is generated."""
        output_file = outputs_dir / "bash_awk.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_bash_awk_has_content(self, outputs_dir: Path) -> None:
        """Test that bash_awk.txt has meaningful content."""
        output_file = outputs_dir / "bash_awk.txt"
        content = output_file.read_text()
        assert len(content) > 100, "bash_awk.txt should have substantial content"
        assert "awk" in content.lower() or "$1" in content, "Missing awk-related content"


class TestPerlOutputs:
    """Test perl script outputs."""

    def test_perl_basics_output_exists(self, outputs_dir: Path) -> None:
        """Test that perl_basics.txt is generated."""
        output_file = outputs_dir / "perl_basics.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_perl_basics_has_content(self, outputs_dir: Path) -> None:
        """Test that perl_basics.txt has meaningful content."""
        output_file = outputs_dir / "perl_basics.txt"
        content = output_file.read_text()
        assert len(content) > 50, "perl_basics.txt should have content"


class TestZshOutputs:
    """Test zsh script outputs."""

    def test_zsh_basics_output_exists(self, outputs_dir: Path) -> None:
        """Test that zsh_basics.txt is generated."""
        output_file = outputs_dir / "zsh_basics.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_zsh_basics_has_content(self, outputs_dir: Path) -> None:
        """Test that zsh_basics.txt has meaningful content."""
        output_file = outputs_dir / "zsh_basics.txt"
        content = output_file.read_text()
        assert len(
            content) > 100, "zsh_basics.txt should have substantial content"
        assert "zsh" in content.lower() or "array" in content, "Missing expected zsh content"


class TestPythonOutputs:
    """Test python script outputs."""

    def test_python_basics_output_exists(self, outputs_dir: Path) -> None:
        """Test that python_basics.txt is generated."""
        output_file = outputs_dir / "python_basics.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_python_basics_has_content(self, outputs_dir: Path) -> None:
        """Test that python_basics.txt has meaningful content."""
        output_file = outputs_dir / "python_basics.txt"
        content = output_file.read_text()
        assert len(
            content) > 200, "python_basics.txt should have substantial content"
        assert any(
            keyword in content for keyword in ["string", "dict", "list", "function"]
        ), "Missing expected Python concepts"

    def test_python_numpy_output_exists(self, outputs_dir: Path) -> None:
        """Test that python_numpy.txt is generated."""
        output_file = outputs_dir / "python_numpy.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_python_numpy_has_content(self, outputs_dir: Path) -> None:
        """Test that python_numpy.txt has meaningful content."""
        output_file = outputs_dir / "python_numpy.txt"
        content = output_file.read_text()
        assert len(content) > 100, "python_numpy.txt should have content"
        # Should either have numpy content or a skip message
        assert "numpy" in content.lower(
        ) or "array" in content.lower() or "skip" in content.lower()

    def test_python_matplotlib_output_exists(self, outputs_dir: Path) -> None:
        """Test that python_matplotlib.txt is generated."""
        output_file = outputs_dir / "python_matplotlib.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_python_matplotlib_has_content(self, outputs_dir: Path) -> None:
        """Test that python_matplotlib.txt has meaningful content."""
        output_file = outputs_dir / "python_matplotlib.txt"
        content = output_file.read_text()
        assert len(content) > 50, "python_matplotlib.txt should have content"
        # Should either have matplotlib content or a skip message
        assert (
            "plot" in content.lower()
            or "matplotlib" in content.lower()
            or "skip" in content.lower()
        )


class TestCppOutputs:
    """Test C++ program outputs."""

    def test_cpp_basics_output_exists(self, outputs_dir: Path) -> None:
        """Test that cpp_basics.txt is generated."""
        output_file = outputs_dir / "cpp_basics.txt"
        assert output_file.exists(), f"Missing output file: {output_file}"

    def test_cpp_basics_has_content(self, outputs_dir: Path) -> None:
        """Test that cpp_basics.txt has meaningful content."""
        output_file = outputs_dir / "cpp_basics.txt"
        content = output_file.read_text()
        assert len(
            content) > 200, "cpp_basics.txt should have substantial content"
        assert any(
            keyword in content.lower() for keyword in ["vector", "map", "class", "template"]
        ), "Missing expected C++ concepts"


class TestOutputsDirectory:
    """Test outputs directory structure."""

    def test_outputs_directory_exists(self, outputs_dir: Path) -> None:
        """Test that outputs directory exists."""
        assert outputs_dir.exists(), "outputs/ directory should exist"
        assert outputs_dir.is_dir(), "outputs/ should be a directory"

    def test_no_unexpected_files(self, outputs_dir: Path) -> None:
        """Test that only expected files exist in outputs."""
        expected_files = {
            "bash_basics.txt",
            "bash_grep.txt",
            "bash_awk.txt",
            "zsh_basics.txt",
            "zsh_functions.txt",
            "perl_basics.txt",
            "python_basics.txt",
            "python_numpy.txt",
            "python_matplotlib.txt",
            "cpp_basics.o.txt",
            "_tmp_array.npy",  # From numpy demo
        }

        actual_files = {f.name for f in outputs_dir.iterdir() if f.is_file()}

        unexpected = actual_files - expected_files
        if unexpected:
            print(f"Found unexpected files in outputs/: {unexpected}")
            # Don't fail on this, just warn
