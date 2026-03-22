"""Setup for cli-anything-pm2 — CLI harness for PM2 process management."""

from setuptools import setup, find_packages

setup(
    name="cli-anything-pm2",
    version="1.0.0",
    description="CLI-Anything harness for PM2 process management",
    author="Velocity Team",
    packages=find_packages(),
    python_requires=">=3.10",
    install_requires=[
        "click>=8.0",
        "prompt-toolkit>=3.0",
    ],
    entry_points={
        "console_scripts": [
            "cli-anything-pm2=cli_anything.pm2.pm2_cli:main",
        ],
    },
)
