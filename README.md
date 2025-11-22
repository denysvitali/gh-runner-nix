# GitHub Actions Runner with Nix

This project provides a drop-in replacement for the official GitHub Actions Runner (ghcr.io/actions/actions-runner), with the addition of xz and Nix installed via Determinate Systems.

## Usage

To use this as a drop-in replacement in your GitHub Actions workflows, simply replace the image with `ghcr.io/<owner>/<repo>:latest`.

## Example Workflow

Create a `.github/workflows/ci.yml` file with the following content:

```yaml
name: CI
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/<owner>/<repo>:latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Run tests
        run: echo "Running tests"
```

## Building

The image is built automatically on pushes to main or version tags via the workflow.