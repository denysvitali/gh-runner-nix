# GitHub Actions Runner with Nix

This project provides a drop-in replacement for the official GitHub Actions Runner (ghcr.io/actions/actions-runner), with the addition of xz and Nix installed via Determinate Systems.

## Usage

To use this as a drop-in replacement in your GitHub Actions Controller, simply replace the image with `ghcr.io/denysvitali/gh-runner-nix:latest`.

## Building

The image is built automatically on pushes to `master` or version tags via the workflow.