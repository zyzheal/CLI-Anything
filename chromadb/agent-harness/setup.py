"""Setup for cli-anything-chromadb."""

from setuptools import setup, find_packages

setup(
    name="cli-anything-chromadb",
    version="1.0.0",
    description="CLI-Anything harness for ChromaDB vector database",
    packages=find_packages(),
    python_requires=">=3.10",
    install_requires=[
        "click>=8.0",
        "prompt-toolkit>=3.0",
        "requests>=2.28",
    ],
    entry_points={
        "console_scripts": [
            "cli-anything-chromadb=cli_anything.chromadb.chromadb_cli:main",
        ],
    },
)
