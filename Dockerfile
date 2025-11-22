FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && apt-get install -y xz-utils

RUN curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm

RUN groupadd nix && usermod -aG nix runner

ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"

USER runner

RUN nix --version